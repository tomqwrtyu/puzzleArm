#!/usr/bin/env python3

"""
 Copyright (C) 2018-2020 Intel Corporation

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
"""

import threading
import os
import sys
from collections import deque
from argparse import ArgumentParser, SUPPRESS
from math import floor as floor
from math import exp as exp
from time import perf_counter
from enum import Enum

import cv2
import numpy as np
from openvino.inference_engine import IECore

import rospy
from std_msgs.msg import String
from std_msgs.msg import Float32MultiArray
from beacon_cam.srv import *


sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'common'))
import helpers
import monitors
import lab
from performance_metrics import PerformanceMetrics


#logging.basicConfig(format="[ %(levelname)s ] %(message)s", level=logging.INFO, stream=sys.stdout)
#log = logging.getLogger()

class arguments:
    def __init__(self):
        self.model = "/home/nvidia/puzzleArm/src/cam/src/yolov4_mnist/frozen_darknet_yolov4_model.xml"
        self.device = "GPU"
        self.labels = ""
        self.prob_threshold = [0.7,0.7,0.7,0.7,0.7,0.7,0.7,0.7,0.7,0.7]
        self.iou_threshold = 0.4
        self.nireq = 1
        self.raw_output_message = False
        self.num_infer_requests = 1
        self.num_streams = ""
        self.number_threads = None
        self.no_show = False
        self.utilization_monitors = ''
        self.keep_aspect_ratio = False


class YoloParams:
    # ------------------------------------------- Extracting layer parameters ------------------------------------------
    # Magic numbers are copied from yolo samples
    def __init__(self, param, side):
        self.num = 3 if 'num' not in param else int(param['num'])
        self.coords = 4 if 'coords' not in param else int(param['coords'])
        self.classes = 80 if 'classes' not in param else int(param['classes'])
        self.side = side
        self.anchors = [10.0, 13.0, 16.0, 30.0, 33.0, 23.0, 30.0, 61.0, 62.0, 45.0, 59.0, 119.0, 116.0, 90.0, 156.0,
                        198.0,
                        373.0, 326.0] if 'anchors' not in param else [float(a) for a in param['anchors'].split(',')]

        self.isYoloV3 = False

        if param.get('mask'):
            mask = [int(idx) for idx in param['mask'].split(',')]
            self.num = len(mask)

            maskedAnchors = []
            for idx in mask:
                maskedAnchors += [self.anchors[idx * 2], self.anchors[idx * 2 + 1]]
            self.anchors = maskedAnchors

            self.isYoloV3 = True # Weak way to determine but the only one.


class Modes(Enum):
    USER_SPECIFIED = 0
    MIN_LATENCY = 1


class Mode():
    def __init__(self, value):
        self.current = value

    def get_other(self):
        return Modes.MIN_LATENCY if self.current == Modes.USER_SPECIFIED \
                                 else Modes.USER_SPECIFIED

    def switch(self):
        self.current = self.get_other()


def scale_bbox(x, y, height, width, class_id, confidence, im_h, im_w, is_proportional):
    if is_proportional:
        scale = np.array([min(im_w/im_h, 1), min(im_h/im_w, 1)])
        offset = 0.5*(np.ones(2) - scale)
        x, y = (np.array([x, y]) - offset) / scale
        width, height = np.array([width, height]) / scale
    xmin = int((x - width / 2) * im_w)
    ymin = int((y - height / 2) * im_h)
    xmax = int(xmin + width * im_w)
    ymax = int(ymin + height * im_h)
    # Method item() used here to convert NumPy types to native types for compatibility with functions, which don't
    # support Numpy types (e.g., cv2.rectangle doesn't support int64 in color parameter)
    return dict(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, class_id=class_id.item(), confidence=confidence.item())


def parse_yolo_region(predictions, resized_image_shape, original_im_shape, params, threshold, is_proportional):
    # ------------------------------------------ Validating output parameters ------------------------------------------
    _, _, out_blob_h, out_blob_w = predictions.shape
    assert out_blob_w == out_blob_h, "Invalid size of output blob. It sould be in NCHW layout and height should " \
                                     "be equal to width. Current height = {}, current width = {}" \
                                     "".format(out_blob_h, out_blob_w)

    # ------------------------------------------ Extracting layer parameters -------------------------------------------
    orig_im_h, orig_im_w = original_im_shape
    resized_image_h, resized_image_w = resized_image_shape
    objects = list()
    size_normalizer = (resized_image_w, resized_image_h) if params.isYoloV3 else (params.side, params.side)
    bbox_size = params.coords + 1 + params.classes
    # ------------------------------------------- Parsing YOLO Region output -------------------------------------------
    for row, col, n in np.ndindex(params.side, params.side, params.num):
        # Getting raw values for each detection bounding box
        bbox = predictions[0, n*bbox_size:(n+1)*bbox_size, row, col]
        x, y, width, height, object_probability = bbox[:5]
        class_probabilities = bbox[5:]
        if object_probability < 0.5:
            continue
        # Process raw value
        x = (col + x) / params.side
        y = (row + y) / params.side
        # Value for exp is very big number in some cases so following construction is using here
        try:
            width = exp(width)
            height = exp(height)
        except OverflowError:
            continue
        # Depends on topology we need to normalize sizes by feature maps (up to YOLOv3) or by input shape (YOLOv3)
        width = width * params.anchors[2 * n] / size_normalizer[0]
        height = height * params.anchors[2 * n + 1] / size_normalizer[1]

        class_id = np.argmax(class_probabilities)
        confidence = class_probabilities[class_id]*object_probability
        if confidence < 0.5:
            continue
        objects.append(scale_bbox(x=x, y=y, height=height, width=width, class_id=class_id, confidence=confidence,
                                  im_h=orig_im_h, im_w=orig_im_w, is_proportional=is_proportional))
    return objects


def intersection_over_union(box_1, box_2):
    width_of_overlap_area = min(box_1['xmax'], box_2['xmax']) - max(box_1['xmin'], box_2['xmin'])
    height_of_overlap_area = min(box_1['ymax'], box_2['ymax']) - max(box_1['ymin'], box_2['ymin'])
    if width_of_overlap_area < 0 or height_of_overlap_area < 0:
        area_of_overlap = 0
    else:
        area_of_overlap = width_of_overlap_area * height_of_overlap_area
    box_1_area = (box_1['ymax'] - box_1['ymin']) * (box_1['xmax'] - box_1['xmin'])
    box_2_area = (box_2['ymax'] - box_2['ymin']) * (box_2['xmax'] - box_2['xmin'])
    area_of_union = box_1_area + box_2_area - area_of_overlap
    if area_of_union == 0:
        return 0
    return area_of_overlap / area_of_union


def resize(image, size, keep_aspect_ratio, interpolation=cv2.INTER_LINEAR):
    if not keep_aspect_ratio:
        return cv2.resize(image, size, interpolation=interpolation)

    iw, ih = image.shape[0:2][::-1]
    w, h = size
    scale = min(w/iw, h/ih)
    nw = int(iw*scale)
    nh = int(ih*scale)
    image = cv2.resize(image, (nw, nh), interpolation=interpolation)
    new_image = np.full((size[1], size[0], 3), 128, dtype=np.uint8)
    dx = (w-nw)//2
    dy = (h-nh)//2
    new_image[dy:dy+nh, dx:dx+nw, :] = image
    return new_image


def preprocess_frame(frame, input_height, input_width, nchw_shape, keep_aspect_ratio):
    in_frame = resize(frame, (input_width, input_height), keep_aspect_ratio)
    if nchw_shape:
        in_frame = in_frame.transpose((2, 0, 1))  # Change data layout from HWC to CHW
    in_frame = np.expand_dims(in_frame, axis=0)
    return in_frame


def get_objects(output, net, new_frame_height_width, source_height_width, prob_threshold, is_proportional):
    objects = list()
    for layer_name, out_blob in output.items():
        out_blob = out_blob.buffer #reshape(net.layers[net.layers[layer_name].parents[0]].out_data[0].shape)
        layer_params = YoloParams(net.layers[layer_name].params, out_blob.shape[2])
        objects += parse_yolo_region(out_blob, new_frame_height_width, source_height_width, layer_params,
                                     prob_threshold, is_proportional)

    return objects


def filter_objects(objects, iou_threshold, prob_threshold):
    # Filtering overlapping boxes with respect to the --iou_threshold CLI parameter
    objects = sorted(objects, key=lambda obj : obj['confidence'], reverse=True)
    for i in range(len(objects)):
        if objects[i]['confidence'] == 0:
            continue
        for j in range(i + 1, len(objects)):
            # We perform IOU only on objects of same class 
            if objects[i]['class_id'] != objects[j]['class_id']: 
                continue

            if intersection_over_union(objects[i], objects[j]) > iou_threshold:
                objects[j]['confidence'] = 0

    return tuple(obj for obj in objects if obj['confidence'] >= prob_threshold[obj['class_id']])


def async_callback(status, callback_args):
    request, frame_id, frame_mode, frame, start_time, completed_request_results, empty_requests, \
    mode, event, callback_exceptions = callback_args

    try:
        if status != 0:
            raise RuntimeError('Infer Request has returned status code {}'.format(status))

        completed_request_results[frame_id] = (frame, request.output_blobs, start_time, frame_mode == mode.current)

        if mode.current == frame_mode:
            empty_requests.append(request)
    except Exception as e:
        callback_exceptions.append(e)

    event.set()


def await_requests_completion(requests):
    for request in requests:
        request.wait() 

def puzzle_pos_to_cam_pos(shape,puzzle_pos):
    try:
        if type(puzzle_pos) == type(int):
            if puzzle_pos <= 8:
                oneThirdOfX = floor(shape[0]/3)
                oneThirdOfY = floor(shape[1]/3)
                i = floor(puzzle_pos/3) + 0.5
                j = puzzle_pos % 3 + 0.5
                return (int(oneThirdOfX*i),int(oneThirdOfY*j))
            else:
                raise ValueError("Error value, should be in the range from 0~8")
        else:
            raise TypeError("Error type.")
    except Exception as e:
       print(repr(e))


def pos_dtm(shape, x, y): #up left for 1,up mid for 2,up right for 3
                           #left for 4,mid for 5,right for 6
                           #down left for 7,down mid for 8,down right for 9
    examine_axes_list = []
    oneThirdOfX = floor(shape[0]/3)
    oneThirdOfY = floor(shape[1]/3)
    examine_x = [0,0]
    examine_y = [0,0]
    for i in range(3):
        j = 0
        examine_x[0] = examine_x[1]
        examine_x[1] += oneThirdOfX
        examine_y = [0,0]
        while(j < 3):
            j += 1
            examine_y[0] = examine_y[1]
            examine_y[1] += oneThirdOfY
            if x >= examine_x[0] and x <= examine_x[1] and y >= examine_y[0] and y <= examine_y[1]:
                return i*3+j
            else:
                continue
    return 'error'

            
def write_line(img,shape):
    oneThirdOfX = floor(shape[0]/3)
    oneThirdOfY = floor(shape[1]/3)
    xmax = shape[0]
    ymax = shape[1]
    x = 0
    y = 0
    for i in range(3):
        x += oneThirdOfX
        cv2.line(img, (0,x), (ymax,x), (0,0,0), 3)
    for j in range(3):
        y += oneThirdOfY
        cv2.line(img, (y,0), (y,xmax), (0,0,0), 3)
    return img

def cam_node():
    def __init__(self):
        self.last_detected_list=[None,None,None,None,None,None,None,None,None]
        self.node = None
        self.pub = None
        
    def start(self):
        self.node = rospy.init_node('cam_node')
        self.pub = rospy.Publisher('cam_detected', Unit8MultiArray, queue_size=10)

    def publish(self,detected_list):
        ret, pub_list = self.__debugging(detected_list)
        self.pub.publish(pub_list)
        return ret

    def __debugging(self,detected_list):#in detected_list index 0 stands for number detected, 
                                       #index 1 stands for position on puzzle,
                                       #index 2 stands for detected position(camera axis).
        n_detected_list = [None] * 9
        not_none_indexs = []
        l_not_none_numbers = 0
        for index,last_result in enumerate(self.last_detected_list):
            if last_result == None:
                continue
            else:
                l_not_none_indexs.append(index)
                l_not_none_numbers += 1
        if l_not_none_numbers == 0: #first step in
            for result in detected_list:
                n_detected_list[result[1]] = result[0]
            self.last_detected_list = n_detected_list
            return detected_list, n_detected_list

        n_not_none_numbers = len(detected_list)

        if not abs(l_not_none_numbers - n_not_none_numbers) == 1: 
            for result in detected_list:
                n_detected_list[result[1]] = result[0]
            self.last_detected_list = n_detected_list
            return detected_list, n_detected_list
        else:    
            last_detected_list = [[index,num] for index,num in self.last_detected_list if not num == None]
            return last_detected_list self.last_detected_list

def main():
    args = arguments()
    args.no_show = False

    #Setup ros node
    camNode = cam_node()
    camNode.start()
    

    # ------------- 1. Plugin initialization for specified device and load extensions library if specified -------------
    rospy.loginfo("Creating Inference Engine...")
    ie = IECore()

    config_user_specified = {}
    config_min_latency = {}

    devices_nstreams = {}
    if args.num_streams:
        devices_nstreams = {device: args.num_streams for device in ['CPU', 'GPU'] if device in args.device} \
                           if args.num_streams.isdigit() \
                           else dict([device.split(':') for device in args.num_streams.split(',')])

    if 'CPU' in args.device:
        if args.cpu_extension:
            ie.add_extension(args.cpu_extension, 'CPU')
        if args.number_threads is not None:
            config_user_specified['CPU_THREADS_NUM'] = str(args.number_threads)
        if 'CPU' in devices_nstreams:
            config_user_specified['CPU_THROUGHPUT_STREAMS'] = devices_nstreams['CPU'] \
                                                              if int(devices_nstreams['CPU']) > 0 \
                                                              else 'CPU_THROUGHPUT_AUTO'

        config_min_latency['CPU_THROUGHPUT_STREAMS'] = '1'

    if 'GPU' in args.device:
        if 'GPU' in devices_nstreams:
            config_user_specified['GPU_THROUGHPUT_STREAMS'] = devices_nstreams['GPU'] \
                                                              if int(devices_nstreams['GPU']) > 0 \
                                                              else 'GPU_THROUGHPUT_AUTO'

        config_min_latency['GPU_THROUGHPUT_STREAMS'] = '1'

    # -------------------- 2. Reading the IR generated by the Model Optimizer (.xml and .bin files) --------------------
    rospy.loginfo("Loading network")
    net = ie.read_network(args.model, os.path.splitext(args.model)[0] + ".bin")

    assert len(net.input_info) == 1, "Sample supports only YOLO V3 based single input topologies"

    # ---------------------------------------------- 3. Preparing inputs -----------------------------------------------
    rospy.loginfo("Preparing inputs")
    input_blob = next(iter(net.input_info))

    # Read and pre-process input images
    if net.input_info[input_blob].input_data.shape[1] == 3:
        input_height, input_width = net.input_info[input_blob].input_data.shape[2:]
        nchw_shape = True
    else:
        input_height, input_width = net.input_info[input_blob].input_data.shape[1:3]
        nchw_shape = False

    if args.labels:
        with open(args.labels, 'r') as f:
            labels_map = [x.strip() for x in f]
    else:
        labels_map = None
    
    mode = Mode(Modes.USER_SPECIFIED)
    
    #Setup camera
    cam = cv2.VideoCapture(0)


    wait_key_time = 1

    # ----------------------------------------- 4. Loading model to the plugin -----------------------------------------
    rospy.loginfo("Loading model to the plugin")
    exec_nets = {}

    exec_nets[Modes.USER_SPECIFIED] = ie.load_network(network=net, device_name=args.device,
                                                      config=config_user_specified,
                                                      num_requests=args.num_infer_requests)
    exec_nets[Modes.MIN_LATENCY] = ie.load_network(network=net, device_name=args.device.split(":")[-1].split(",")[0],
                                                   config=config_min_latency,
                                                   num_requests=1)

    empty_requests = deque(exec_nets[mode.current].requests)
    completed_request_results = {}
    next_frame_id = 0
    next_frame_id_to_show = 0
    mode_metrics = {mode.current: PerformanceMetrics()}
    prev_mode_active_request_count = 0
    event = threading.Event()
    callback_exceptions = []

    # ----------------------------------------------- 5. Doing inference -----------------------------------------------
    rospy.loginfo("Starting inference...")
    #print("To close the application, press 'CTRL+C' here or switch to the output window and press ESC key")
    #print("To switch between min_latency/user_specified modes, press TAB key in the output window")

    presenter = monitors.Presenter(args.utilization_monitors, 55, 1280, 720)
        #(round(cap.get(cv2.CAP_PROP_FRAME_WIDTH) / 4), round(cap.get(cv2.CAP_PROP_FRAME_HEIGHT) / 8)))
            
    
    while (not cam.isOpened() \
           or completed_request_results \
           or len(empty_requests) < len(exec_nets[mode.current].requests)) \
          and not callback_exceptions and not rospy.is_shutdown():
        if next_frame_id_to_show in completed_request_results:
            frame, output, start_time, is_same_mode = completed_request_results.pop(next_frame_id_to_show)

            next_frame_id_to_show += 1

            objects = get_objects(output, net, (input_height, input_width), frame.shape[:-1], args.prob_threshold,
                                  args.keep_aspect_ratio)
            objects = filter_objects(objects, args.iou_threshold, args.prob_threshold)

            if len(objects) and args.raw_output_message:
                rospy.loginfo(" Class ID | Confidence | XMIN | YMIN | XMAX | YMAX | COLOR ")

            origin_im_size = frame.shape[:-1]
            presenter.drawGraphs(frame)
         
            detected_list = []
            for obj in objects:
                # Validation bbox of detected object
                obj['xmax'] = min(obj['xmax'], origin_im_size[1])
                obj['ymax'] = min(obj['ymax'], origin_im_size[0])
                obj['xmin'] = max(obj['xmin'], 0)
                obj['ymin'] = max(obj['ymin'], 0)
                xavg = int((obj['xmin']+obj['xmax'])/2)
                yavg = int((obj['ymin']+obj['ymax'])/2)
                det_label = labels_map[obj['class_id']] if labels_map and len(labels_map) >= obj['class_id'] else \
                    str(obj['class_id'])       
                detected_list.append([det_label, pos_dtm(frame.shape,yavg,xavg)])
                if args.raw_output_message:
                    rospy.loginfo(
                        "{:^9} | {:10f} | {:4} | {:4} | {:4} | {:4} | {} ".format(det_label, obj['confidence'],
                                                                                  obj['xmin'], obj['ymin'], obj['xmax'],
                                                                                  obj['ymax']))
                
            imgToShow = np.zeros((frame.shape[0],frame.shape[1],3), np.uint8)
            imgToShow.fill(255)
            imgToShow = write_line(imgToShow,frame.shape)

            cam.publish(detected_list) 
            
            if any(detected_list):
                for detected_number in detected_list:
                    color = (min(int(detected_number[0]) * 25, 255),
                             min(int(detected_number[0]) * 14, 255),
                             min(int(detected_number[0]) * 10, 255))
                    cv2.putText(imgToShow,
                                str(detected_number[0]),
                                puzzle_pos_to_cam_pos(frame.shape, detected_number[1]), cv2.FONT_HERSHEY_DUPLEX, 2, color, 2)
                            
            if is_same_mode and prev_mode_active_request_count == 0:
                mode_metrics[mode.current].update(start_time, frame)
            else:
                mode_metrics[mode.get_other()].update(start_time, frame)
                prev_mode_active_request_count -= 1
                helpers.put_highlighted_text(frame, "Switching modes, please wait...",
                                             (10, int(origin_im_size[0] - 50)), cv2.FONT_HERSHEY_COMPLEX, 0.75,
                                             (10, 200, 10), 2)
            if not args.no_show:
                cv2.namedWindow("Detection Results", cv2.WINDOW_NORMAL)#cv2.WND_PROP_FULLSCREEN)
                #cv2.setWindowProperty("Detection Results", cv2.WND_PROP_FULLSCREEN,  cv2.WINDOW_FULLSCREEN)
                cv2.imshow("Detection Results", imgToShow)
                key = cv2.waitKey(wait_key_time)

                if key in {ord("q"), ord("Q"), 27}: # ESC key
                    cv2.destoryAllWindows()
                    break
                if key == 9: # Tab key
                    if prev_mode_active_request_count == 0:
                        prev_mode = mode.current
                        mode.switch()

                        prev_mode_active_request_count = len(exec_nets[prev_mode].requests) - len(empty_requests)
                        empty_requests.clear()
                        empty_requests.extend(exec_nets[mode.current].requests)

                        #mode_metrics[mode.current] = PerformanceMetrics()
                else:
                    presenter.handleKey(key)
                

        elif empty_requests and prev_mode_active_request_count == 0 and cam_isOpened():
            start_time = perf_counter()
            ret,frame = cam.read()

            request = empty_requests.popleft()

            # resize input_frame to network size
            in_frame = preprocess_frame(frame, input_height, input_width, nchw_shape, args.keep_aspect_ratio)

            # Start inference
            request.set_completion_callback(py_callback=async_callback,
                                            py_data=(request,
                                                     next_frame_id,
                                                     mode.current,
                                                     frame,
                                                     start_time,
                                                     completed_request_results,
                                                     empty_requests,
                                                     mode,
                                                     event,
                                                     callback_exceptions))
            request.async_infer(inputs={input_blob: in_frame})
            next_frame_id += 1

        else:
            event.wait()
            event.clear()

    if callback_exceptions:
        raise callback_exceptions[0]

    for mode, metrics in mode_metrics.items():
        print("\nMode: {}".format(mode.name))
        metrics.print_total()
    print(presenter.reportMeans())

    for exec_net in exec_nets.values():
        await_requests_completion(exec_net.requests)
        
    cam.realease()


if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
