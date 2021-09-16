import rospy
from std_msgs.msg import String
from std_msgs.msg import Float32MultiArray
from std_msgs.msg import UInt8MultiArray
from cam.srv import *

import numpy as np
from math import floor
import time

NONE_VALUE = 999
INVALID_BOX_RATIO = 0.5

class camNode():#For ROS node establish and publish
    def __init__(self):
        self.node = None
        self.pub = None
        self.write_video = None
        self.is_initialized = False
        self.xminmax = {'min' = None, 'max' = None}
        self.yminmax = {'min' = None, 'max' = None}
        self.message_to_pub = UInt8MultiArray()
        self.message_to_pub.data = [NONE_VALUE] * 9
        self.vanish_determinator = []
        self.confs_recorder = []
        self.average_wh_ratio_recorder = None
        
    def start(self):
        self.node = rospy.init_node('cam_node')
        self.pub = rospy.Publisher('cam_detected', UInt8MultiArray, queue_size=10)
        
    def initializeBoxPosition(self,detected_list):
        if not len(detected_list) == 9:
            return 1
        xlist = []
        ylist = []
        for item in detected_list:
            xlist.append(item['axes'][0])
            ylist.append(item['axes'][1])
        self.xminmax['min'] = min(xlist)
        self.xminmax['max'] = max(xlist)
        self.yminmax['min'] = min(ylist)
        self.yminmax['max'] = max(ylist)
        for item in detected_list:
            if item['number'] != self.__positionDetermine(item['axes'][0], item['axes'][1])
                return 1
        self.is_initialized = True
        return 0
            
    
        
    def generateListForPublish(self, shape, boxes, confs, classes, cls_dict): #boxes : [ymin,xmin,ymax,xmax]
        detected_objects = []
        classes = np.int8(classes)
        for index,box in enumerate(boxes):
            wh_ratio = self.__ratioCaculate(box[1], box[0], box[3], box[2])
            if self.average_wh_ratio_recorder == None:
                pass
            elif (wh_ratio * INVALID_BOX_RATIO > self.average_wh_ratio_recorder['avg']):
                continue
            self.__ratioUpdate(wh_ratio)
            xavg = floor((box[1] + box[3]) / 2)
            yavg = floor((box[0] + box[2]) / 2)
            if not self.is_initialized:
                detected_object = {'number':cls_dict[classes[index]],
                               'conf':confs[index],
                               'axes':(xavg, yavg)}
            else:
                detected_object = {'number':cls_dict[classes[index]],
                                   'conf':confs[index],
                                   'pos':self.__positionDetermine(xavg, yavg)}
            detected_objects.append(detected_object)
        return detected_objects
        
    def __positionDetermine(self, x, y): #up left for 1,up mid for 2,up right for 3
                                                                 #left for 4,mid for 5,right for 6
                                                                 #down left for 7,down mid for 8,down right for 9
        xmin = self.xminmax['min']
        xmax = self.xminmax['max']
        ymin = self.yminmax['min']
        ymax = self.yminmax['max']
        try:
            examine_axes_list = []
            oneThirdOfX = floor((xmax - xmin)/3)
            oneThirdOfY = floor((ymax - ymin)/3)
            examine_x = [xmin,xmin]
            for i in range(3):
                j = 0
                examine_x[0] = examine_x[1]
                examine_x[1] += oneThirdOfX
                examine_y = [ymin,ymin]
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
    
    def __ratioCaculate(self, xmin, ymin, xmax, ymax): #this 
        height = xmax - xmin
        width = ymax - ymin
        return (width / height)
        
    def __ratioUpdate(self, new_ratio):
        if self.average_wh_ratio_recorder == None:
            if new_ratio < 0.7:
                return 0
            self.average_wh_ratio_recorder = {'avg':new_ratio, 'num_boxes':1}
        else:
            avg = self.average_wh_ratio_recorder['avg'] 
            num_boxes = self.average_wh_ratio_recorder['num_boxes'] 
            self.average_wh_ratio_recorder['avg'] = (avg * num_boxes + new_ratio) / (num_boxes + 1)
            self.average_wh_ratio_recorder['num_boxes'] = num_boxes + 1

    def publish(self,detected_list):
        pub_message = self.__debugging(detected_list)
        self.pub.publish(pub_message)
        ret = [str(data) for data in pub_message.data]
        return ret

    def __debugging(self,detected_list):#Warning!! This code may be useless
                                        
        self.message_to_pub.layout = time.time()
        new_detected_list = [NONE_VALUE] * 9
        confs = [NONE_VALUE] * 9 
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
            if not last_result == NONE_VALUE:
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
        else: #Assume no detection error,there are some numbers being discovered or no obstacle interfering the detection.
            for index, new_num in enumerate(new_detected_list):
                if index not in invalid_changed_indexs:
                    self.message_to_pub.data[index] = new_num
                    
        return self.message_to_pub 

