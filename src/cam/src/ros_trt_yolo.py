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

from utils.yolo_classes import get_cls_dict
from utils.camera import add_camera_args, Camera
from utils.display import open_window, set_display, show_fps
from utils.visualization import BBoxVisualization
from utils.yolo_with_plugins import TrtYOLO
from utils.yolo_ros_puzzle import camNode

import tkinter as tk
from tkinter.messagebox import askyesno

import rospy

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
        '-m', '--model', type=str, default='yolov4-tiny_78_0914',
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
    parser.add_argument(
        '__name', action='store_true',
        help='meaningless arg')
    parser.add_argument(
        '__log', action='store_true',
        help='meaningless arg')
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
    tkBlock = tk.Tk()
    publishButton = 0 #

    #Setup opencv video writer
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    video_shape = (cam.img_handle.shape[1],cam.img_handle.shape[0])
    out = cv2.VideoWriter('result.mp4', fourcc, 30.0, video_shape)
    while not rospy.is_shutdown():
        if cv2.getWindowProperty(WINDOW_NAME, 0) < 0:
            break
        img = cam.read()
        if img is None:
            break
        boxes, confs, clss = trt_yolo.detect(img, conf_th) #boxes : [ymin,xmin,ymax,xmax]
        img = vis.draw_bboxes(img, boxes, confs, clss)
        #img = show_fps(img, fps)

        raw_list = node.generateListForPublish(cam.img_handle.shape, boxes, confs, clss, cls_dict)
        if not node.is_initialized :
            ret = node.initializeBoxPosition(raw_list)
            if ret == 1:
                cv2.putText(img,
                            'Initializing failed. Please put 9 numbers to right places.',
                            (int(cam.img_handle.shape[1]/10), int(cam.img_handle.shape[0]/10)),
                            cv2.FONT_HERSHEY_DUPLEX, 0.6, (0, 0, 200), 1)
                cv2.imshow(WINDOW_NAME, img)
                key = cv2.waitKey(1)
                if key == 27:  # ESC key: quit program
                    break
                elif key == ord('F') or key == ord('f'):  #Toggle fullscreen
                    full_scrn = not full_scrn
                    set_display(WINDOW_NAME, full_scrn)
                continue
        else:
            list_for_publish = node.toPublishFormat(raw_list)
            list_for_show = [str(data) for data in list_for_publish.data]
            if publishButton:
                node.publish(list_for_publish)
            list_for_show.reverse()
            nine_squares_img = summonNineSquares(cam.img_handle.shape)    
            if any(list_for_show):
                for index,detected_number in enumerate(list_for_show):
                    if detected_number == '999':
                        continue
                    color = (255,255,255)#min(int(detected_number) * 25, 255),
                             #min(int(detected_number) * 14, 255),
                             #min(int(detected_number) * 10, 255))
                    cv2.putText(nine_squares_img,
                                str(detected_number),
                                puzzlePosToCamPos(cam.img_handle.shape, index+1),
                                cv2.FONT_HERSHEY_DUPLEX, 1.2, color, 1)
            nine_squares_img = show_fps(nine_squares_img, fps)
            if node.write_video:
                out.write(nine_squares_img)
            cv2.imshow(WINDOW_NAME, nine_squares_img)
        

            toc = time.time()
            curr_fps = 1.0 / (toc - tic)
            # calculate an exponentially decaying average of fps number
            fps = curr_fps if fps == 0.0 else (fps*0.95 + curr_fps*0.05)
            tic = toc
            key = cv2.waitKey(1)
            if key == ord('P') or key == ord('p'): 
                if publishButton:
                    publishButton = 0
                else:
                    publishButton = 1
            if key == 27:  # ESC key: quit program
                break
            elif key == ord('F') or key == ord('f'):  #Toggle fullscreen
                full_scrn = not full_scrn
                set_display(WINDOW_NAME, full_scrn)
            elif key == ord('R') or key == ord('r'):  #Reinitialize plate position (!!!Not sure if the messagebox working!!!)
                tkBlock.withdraw()
                answer = askyesno(title = 'Warning!',
                                  message = 'Are you sure that you want to reset?')
                if answer:
                    node.reset()
                
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
            
def summonNineSquares(shape):#As the funcion name says.
    img = np.zeros((shape[0], shape[1], 3), np.uint8)
    img.fill(0)
    oneThirdOfX = floor(shape[0]/3)
    oneThirdOfY = floor(shape[1]/3)
    xmax = shape[0]
    ymax = shape[1]
    x = 0
    y = 0
    for i in range(3):
        x += oneThirdOfX
        cv2.line(img, (0,x), (ymax,x), (255,255,255), 3)
    for j in range(3):
        y += oneThirdOfY
        cv2.line(img, (y,0), (y,xmax), (255,255,255), 3)
    return img
        

def main():
    args = parse_args()
    abs_path = os.path.dirname(os.path.abspath(__file__))
    if args.category_num <= 0:
        raise SystemExit('ERROR: bad category_num (%d)!' % args.category_num)
    trt_dir = abs_path + '/yolo/%s.trt' % args.model
    if not os.path.isfile(trt_dir):
        raise SystemExit('ERROR: file (%s.trt) not found!' % args.model)

    #Setup cam
    args.usb = 2
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
