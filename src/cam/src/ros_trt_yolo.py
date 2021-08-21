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
    while True:
        if cv2.getWindowProperty(WINDOW_NAME, 0) < 0:
            break
        img = cam.read()
        if img is None:
            break
        boxes, confs, clss = trt_yolo.detect(img, conf_th) #boxes : [ymin,xmin,ymax,xmax]

        list_for_publish =  generateListForPublish(cam.img_handle.shape, boxes, clss, cls_dict)   
        node.publish(list_for_publish) 
        nine_squares_img = summonNineSquares(cam.img_handle.shape)
        if any(list_for_publish):
            for detected_number in list_for_publish:
                color = (min(int(detected_number[0]) * 25, 255),
                         min(int(detected_number[0]) * 14, 255),
                         min(int(detected_number[0]) * 10, 255))
                cv2.putText(nine_squares_img,
                            str(detected_number[0]),
                            puzzlePosToCamPos(cam.img_handle.shape, detected_number[1]),
                            cv2.FONT_HERSHEY_DUPLEX, 1, color, 1)
        nine_squares_img = show_fps(nine_squares_img, fps)
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

def generateListForPublish(shape, boxes, classes, cls_dict): #boxes : [ymin,xmin,ymax,xmax]
    detected_objects = []
    classes = np.int8(classes)
    for index,box in enumerate(boxes):
        xavg = floor((box[1] + box[3]) / 2)
        yavg = floor((box[0] + box[2]) / 2)
        detected_object = [cls_dict[classes[index]],positionDetermine(shape,xavg,yavg),(xavg, yavg)]
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
        #self.last_tracking_time = None
        self.message_to_pub = UInt8MultiArray()
        self.node = None
        self.pub = None
        
    def start(self):
        self.node = rospy.init_node('cam_node')
        self.pub = rospy.Publisher('cam_detected', UInt8MultiArray, queue_size=10)

    def publish(self,detected_list):
        pub_list = self.__debugging(detected_list)
        self.pub.publish(pub_list)

    def __debugging(self,detected_list):#in detected_list index 0 stands for number detected, 
                                        #index 1 stands for position on puzzle,
                                        #index 2 stands for detected position(camera 2D axis).
                                        #Warning!! This code may be useless
        self.message_to_pub.layout = time.time()
        new_detected_list = [999] * 9
        l_not_none_indexs = []
        l_not_none_numbers = 0
        for index,last_result in enumerate(self.message_to_pub.data):
            if last_result == 999:
                continue
            else:
                l_not_none_indexs.append(index)
                l_not_none_numbers += 1
        if l_not_none_numbers == 0: #first step in
            for result in detected_list:
                new_detected_list[result[1]-1] = int(result[0])
            self.message_to_pub.data = new_detected_list
            print(self.message_to_pub.layout,self.message_to_pub.data,'first')
            return self.message_to_pub

        n_not_none_numbers = len(detected_list)

        if l_not_none_numbers - n_not_none_numbers > 0: #Assume no detection error,there are some numbers being covered.
            print(self.message_to_pub.layout,self.message_to_pub.data,'case 1')
            return self.message_to_pub #Return list before covering and no change in last detected list
        else: #Assume no detection error,there are some numbers being discovered or no obstacle interfering the detection.
            for result in detected_list:
                new_detected_list[result[1]-1] = int(result[0])
            self.message_to_pub.data = new_detected_list
            print(self.message_to_pub.layout,self.message_to_pub.data,'case 2')
            return self.message_to_pub#Update and return last_detected_list 

def main():
    args = parse_args()
    abs_dir = os.path.join(os.path.abspath(r"."),'src','cam','src')
    if args.category_num <= 0:
        raise SystemExit('ERROR: bad category_num (%d)!' % args.category_num)
    trt_dir = abs_dir + '/yolo/%s.trt' % args.model
    if not os.path.isfile(trt_dir):
        raise SystemExit('ERROR: file (%s.trt) not found!' % args.model)

    cam = Camera(args)
    if not cam.isOpened():
        raise SystemExit('ERROR: failed to open camera!')
    
    node = camNode()
    node.start()


    cls_dict = get_cls_dict(args.category_num)
    vis = BBoxVisualization(cls_dict)
    trt_yolo = TrtYOLO(args.model, args.category_num, args.letter_box)

    open_window(
        WINDOW_NAME, 'Camera TensorRT YOLO Demo',
        cam.img_width, cam.img_height)
    loop_and_detect(node, cam, trt_yolo, cls_dict, conf_th=0.6, vis=vis)

    cam.release()
    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()
