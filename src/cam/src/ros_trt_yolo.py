#!/usr/bin/env python3
"""trt_yolo.py

This script demonstrates how to do real-time object detection with
TensorRT optimized YOLO engine.
"""


import os
import time
import argparse
from math import floor
import numpy as np

import cv2
import pycuda.autoinit  # This is needed for initializing CUDA driver

import rospy
from std_msgs.msg import String
from std_msgs.msg import Float32MultiArray
from std_msgs.msg import UInt8MultiArray
from cam.srv import *

from utils.yolo_classes import get_cls_dict
from utils.camera import add_camera_args, Camera
from utils.display import open_window, set_display, show_fps
from utils.visualization import BBoxVisualization
from utils.yolo_with_plugins import TrtYOLO


WINDOW_NAME = 'ROSTrtYOLODemo'
NONE_VALUE = 999


def parse_args():
    """Parse input arguments."""
    desc = ('Capture and display live camera video, while doing '
            'real-time object detection with TensorRT optimized '
            'YOLO model on Jetson')
    parser = argparse.ArgumentParser(description=desc)
    parser = add_camera_args(parser)
    parser.add_argument(
        '-c', '--category_num', type=int, default=9,
        help='number of object categories [9]')
    parser.add_argument(
        '-m', '--model', type=str, default='yolov4-tiny_40_0814',
        help=('[yolov3-tiny|yolov3|yolov3-spp|yolov4-tiny|yolov4|'
              'yolov4-csp|yolov4x-mish]-[{dimension}], where '
              '{dimension} could be either a single number (e.g. '
              '288, 416, 608) or 2 numbers, WxH (e.g. 416x256)'))
    parser.add_argument(
        '-w', '--write_video', type=bool, default=False,
        help=('Write the result video.'))
    parser.add_argument(
        '-l', '--letter_box', action='store_true',
        help='inference with letterboxed image [False]')
    args = parser.parse_args()
    return args

def loop_and_detect(node, cam, trt_yolo, cls_dict, conf_th, vis):
    """Continuously capture images from camera and do object detection.

    # Arguments
      cam: the camera instance (video source).
      trt_yolo: the TRT YOLO object detector instance.
      conf_th: confidence/score threshold for object detection.
      vis: for visualization.
    """
    full_scrn = False
    fps = 0.0
    tic = time.time()

    #Setup opencv video writer
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    video_shape = (cam.img_handle.shape[1],cam.img_handle.shape[0])
    out = cv2.VideoWriter('result.mp4', fourcc, 30.0, video_shape)
    while True:
        if cv2.getWindowProperty(WINDOW_NAME, 0) < 0:
            break
        img = cam.read()
        if img is None:
            break
        boxes, confs, clss = trt_yolo.detect(img, conf_th) #boxes : [ymin,xmin,ymax,xmax]

        list_for_publish = generateListForPublish(cam.img_handle.shape, boxes, confs, clss, cls_dict)
        list_for_show = node.publish(list_for_publish)
        nine_squares_img = summonNineSquares(cam.img_handle.shape)
        if any(list_for_show):
            for index,detected_number in enumerate(list_for_show):
                color = (min(int(detected_number) * 25, 255),
                         min(int(detected_number) * 14, 255),
                         min(int(detected_number) * 10, 255))
                cv2.putText(nine_squares_img,
                            str(detected_number),
                            puzzlePosToCamPos(cam.img_handle.shape, index+1),
                            cv2.FONT_HERSHEY_DUPLEX, 1, color, 1)
        nine_squares_img = show_fps(nine_squares_img, fps)
        out.write(nine_squares_img)
        cv2.imshow(WINDOW_NAME, nine_squares_img)
        

        toc = time.time()
        curr_fps = 1.0 / (toc - tic)
        # calculate an exponentially decaying average of fps number
        fps = curr_fps if fps == 0.0 else (fps*0.95 + curr_fps*0.05)
        tic = toc
        key = cv2.waitKey(1)
        if key == 27:  # ESC key: quit program
            break
        elif key == ord('F') or key == ord('f'):  #Toggle fullscreen
            full_scrn = not full_scrn
            set_display(WINDOW_NAME, full_scrn)
    out.release()
     

def puzzlePosToCamPos(shape, puzzle_pos):#Convert 1~9 to position on image
    try:
        if puzzle_pos <= 9 and puzzle_pos >= 1:
            puzzle_pos = puzzle_pos - 1
            oneThirdOfX = floor(shape[0]/3)
            oneThirdOfY = floor(shape[1]/3)
            i = (lambda x: floor(x/3) + 0.5 if floor(x/3) > 0.5 else 0.5)(puzzle_pos)
            j = (lambda x: x % 3 + 0.5 if x % 3 > 0.5 else 0.5)(puzzle_pos)
            return (int(oneThirdOfY*j),int(oneThirdOfX*i))#cv2 image need (pixel in width,pixel in height)
        else:
            raise ValueError("Error value, should be in the range from 1~9")
    except Exception as e:
       print(repr(e))


def positionDetermine(shape, x, y): #up left for 1,up mid for 2,up right for 3
                                    #left for 4,mid for 5,right for 6
                                    #down left for 7,down mid for 8,down right for 9
    try:
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
        raise Exception("Unexpected Error.")
    except Exception as e:
        print(repr(e))

def generateListForPublish(shape, boxes, confs, classes, cls_dict): #boxes : [ymin,xmin,ymax,xmax]
    detected_objects = []
    classes = np.int8(classes)
    for index,box in enumerate(boxes):
        xavg = floor((box[1] + box[3]) / 2)
        yavg = floor((box[0] + box[2]) / 2)
        detected_object = {'number':cls_dict[classes[index]],
                           'conf':confs[index],
                           'pos':positionDetermine(shape,xavg,yavg)}
                           #'axes':(xavg, yavg)}
        detected_objects.append(detected_object)
    return detected_objects
            
def summonNineSquares(shape):#As the funcion name says.
    img = np.zeros((shape[0], shape[1], 3), np.uint8)
    img.fill(255)
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

class camNode():#For ROS node establish and publish
    def __init__(self):
        self.write_video = True
        self.message_to_pub = UInt8MultiArray()
        self.message_to_pub.data = [NONE_VALUE] * 9
        self.vanish_determinator = []
        self.confs_recorder = []
        self.node = None
        self.pub = None
        
    def start(self):
        self.node = rospy.init_node('cam_node')
        self.pub = rospy.Publisher('cam_detected', UInt8MultiArray, queue_size=10)

    def publish(self,detected_list):
        pub_message = self.__debugging(detected_list)
        self.pub.publish(pub_message)
        ret = [str(data) for data in pub_message.data]
        return ret

    def __debugging(self,detected_list):#Warning!! This code may be useless
                                        
        self.message_to_pub.layout = time.time()
        new_detected_list = [NONE_VALUE] * 9
        confs = [NONE_VALUE] * 9 
        l_not_none_indexs = []
        l_not_none_numbers = 0
        
        tmp_dict = {}
        for index, number in enumerate(detected_list):#Purge duplicate numbers,left only with highest conference.
            if number['number'] not in tmp_dict:
                tmp_dict[number['number']] = [(number['conf'], index)]
            else:
                tmp_dict[number['number']].append((number['conf'], index))
                tmp_dict[number['number']] = sorted(tmp_dict[number['number']], key=lambda x:x[0])
        for item in tmp_dict.items():
            if len(item[1]) == 1:
                continue
            else:
                for i in range(len(item[1])-1):
                    detected_list[item[1][i][1]] = None
        detected_list = [item for item in detected_list if not item == None]
        
        for index, last_result in enumerate(self.message_to_pub.data):#Caculate how many numbers is not NONE_VALUE(999)
                                                                      #in last stored data.
            if last_result == NONE_VALUE:
                continue
            else:
                l_not_none_indexs.append(index)
                l_not_none_numbers += 1
        
        invalid_changed_indexs = [] #Record numbers change from number to number.(invalid change)
        covered_conter = 0 #Caculate how many numbers are no-longer detected
        new_vanish_determinator = []
        for result in detected_list: #Unpack recieved data
            new_detected_list[result['pos']-1] = int(result['number'])
            confs[result['pos']-1] = result['conf']
        for index, detect_number in enumerate(new_detected_list):
            if detect_number == NONE_VALUE and not self.message_to_pub.data[index] == NONE_VALUE:
                covered_conter += 1
                new_vanish_determinator.append((index, self.message_to_pub.data[index]))
            elif(not detect_number == NONE_VALUE 
                 and not self.message_to_pub.data[index] == detect_number
                 and not self.message_to_pub.data[index] == NONE_VALUE):
                invalid_changed_indexs.append(index)

        if any(self.vanish_determinator):
            for record in self.vanish_determinator:
                if new_detected_list[record[0]] == record[1]:
                    self.vanish_determinator.remove(record) #Covered but not removed
                if record in new_vanish_determinator:
                    new_vanish_determinator.remove(record) #Remove vanished

            for index,num in self.vanish_determinator:
                if index in invalid_changed_indexs and confs[index] >= self.confs_recorder[index]:
                    invalid_changed_indexs.remove(index) #Remove valid change(removed)

        for new_record in new_vanish_determinator:
            self.vanish_determinator.append(new_record)
        self.confs_recorder = confs
            
        n_not_none_numbers = len(detected_list) #Caculate how many numbers is not NONE_VALUE(999)
                                                #in new recieved data.

        if l_not_none_numbers - n_not_none_numbers > 0 and not covered_conter == 0: #Some numbers are covered or vanished
            for index, new_num in enumerate(new_detected_list):
                if not new_num == NONE_VALUE and index not in invalid_changed_indexs:
                    if new_num in self.message_to_pub.data: 
                        self.message_to_pub.data[self.message_to_pub.data.index(new_num)] = NONE_VALUE
                    self.message_to_pub.data[index] = new_num #update old data but not alternate
            return self.message_to_pub #Return list before covering and no change in last detected list
        else: #Assume no detection error,there are some numbers being discovered or no obstacle interfering the detection.
            for index, new_num in enumerate(new_detected_list):
                if index not in invalid_changed_indexs:
                    self.message_to_pub.data[index] = new_num
            return self.message_to_pub #Update and return last_detected_list 
        

def main():
    args = parse_args()
    abs_path = os.path.dirname(os.path.abspath(__file__))
    if args.category_num <= 0:
        raise SystemExit('ERROR: bad category_num (%d)!' % args.category_num)
    trt_dir = abs_path + '/yolo/%s.trt' % args.model
    if not os.path.isfile(trt_dir):
        raise SystemExit('ERROR: file (%s.trt) not found!' % args.model)

    #Setup cam
    cam = Camera(args)
    if not cam.isOpened():
        raise SystemExit('ERROR: failed to open camera!')
    
    #Setup ROS Node
    node = camNode()
    node.write_video = args.write_video
    node.start()

    cls_dict = get_cls_dict(args.category_num)
    vis = BBoxVisualization(cls_dict)
    trt_yolo = TrtYOLO(args.model, args.category_num, args.letter_box)

    open_window(
        WINDOW_NAME, 'Camera TensorRT YOLO Demo',
        cam.img_width, cam.img_height)
    loop_and_detect(node, cam, trt_yolo, cls_dict, conf_th=0.7, vis=vis)

    cam.release()
    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()
