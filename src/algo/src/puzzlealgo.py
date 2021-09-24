#!/usr/bin/env python3
import sys
import copy
import math
# heapq is similar to priorty queue
import heapq
import argparse
import time

import rospy
from std_msgs.msg import String
from cam.msg import UIntArray
from cam.srv import *


GOAL_STATE = [1, 2, 3, 
                 4, 5, 6, 
                 7, 8, 9]

START1 = [None, 3, 7, 
         1, 2, 8, 
         5, 6, 4]
#d r d r u l l

START = [1, 2, 3, 
        4, 5, 6, 
        None,7, 8]

START_DICT = {"start": START,
               "start1":START1}

class Stack:
  "A container with a last-in-first-out (LIFO) queuing policy."
  def __init__(self):
    self.list = []
    
  def push(self,item):
    "Push 'item' onto the stack"
    self.list.append(item)

  def pop(self):
    "Pop the most recently pushed item from the stack"
    return self.list.pop()

  def isEmpty(self):
    "Returns true if the stack is empty"
    return len(self.list) == 0

class Queue:
  "A container with a first-in-first-out (FIFO) queuing policy."
  def __init__(self):
    self.list = []
  
  def push(self,item):
    "Enqueue the 'item' into the queue"
    self.list.insert(0,item)

  def pop(self):
    """
      Dequeue the earliest enqueued item still in the queue. This
      operation removes the item from the queue.
    """
    return self.list.pop()

  def isEmpty(self):
    "Returns true if the queue is empty"
    return len(self.list) == 0


class Node(object):
    def __init__(self, value):
        self.value = value
        self.cost = None
        self.total_cost = None
        self.parent = None
        self.point_to_childern = None

    def __repr__(self):
        return str(self.value)
        
    def __lt__(self, other):
        return self.total_cost < other.total_cost

    def __le__(self, other):
        return self.total_cost <= other.total_cost

class PuzzleSearch(object):

    def __init__(self, start, goal):
        self.start = start
        self.goal = goal
        self.nodes = []


    def _position_by_value(self, node, value):
        cells = int(math.sqrt(len(node)))
        row_idx = node.index(value) // cells
        col_idx = node.index(value) % cells
        return row_idx, col_idx

    def _move_left(self, node):
        row_idx, col_idx = self._position_by_value(node, None)
        cells = int(math.sqrt(len(node)))
        if col_idx != 0:
            newnode = copy.deepcopy(node)
            idx_old = int(cells * row_idx + col_idx)
            idx_new = int(cells * row_idx + col_idx-1)
            new_val = node[idx_new]
            newnode[idx_old] = new_val
            newnode[idx_new] = None
            return newnode, 'left'
        return None, None

    def _move_right(self, node):
        row_idx, col_idx = self._position_by_value(node, None)
        cells = int(math.sqrt(len(node)))
        max_col = cells-1
        if col_idx != max_col:
            newnode = copy.deepcopy(node)
            idx_old = int(cells * row_idx + col_idx)
            idx_new = int(cells * row_idx + col_idx+1)
            new_val = node[idx_new]
            newnode[idx_old] = new_val
            newnode[idx_new] = None
            return newnode, 'right'
        return None, None

    def _move_up(self, node):
        row_idx, col_idx = self._position_by_value(node, None)
        cells = int(math.sqrt(len(node)))
        if row_idx != 0:
            newnode = copy.deepcopy(node)
            idx_old = int(cells * row_idx + col_idx)
            idx_new = int(cells * (row_idx-1) + col_idx)
            new_val = node[idx_new]
            newnode[idx_old] = new_val
            newnode[idx_new] = None
            return newnode, 'up'
        return None, None

    def _move_down(self, node):
        row_idx, col_idx = self._position_by_value(node, None)
        cells = int(math.sqrt(len(node)))
        max_row = cells-1
        if row_idx != max_row:
            newnode = copy.deepcopy(node)
            idx_old = int(cells * row_idx + col_idx)
            idx_new = int(cells * (row_idx+1) + col_idx)
            new_val = node[idx_new]
            newnode[idx_old] = new_val
            newnode[idx_new] = None
            return newnode, 'down'
        return None, None

    def get_children(self, node):
        tmp_nodes = []
        new_node_list = []
        tmp_directions = []
        new_directions = []
        mvdown, mvdown_dir = self._move_down(node)
        mvup, mvup_dir = self._move_up(node)
        mvlf, mvlf_dir = self._move_left(node)
        mvrt, mvrt_dir = self._move_right(node)
        tmp_nodes.append(mvdown)
        tmp_nodes.append(mvup)
        tmp_nodes.append(mvlf)
        tmp_nodes.append(mvrt)
        tmp_directions.append(mvdown_dir)
        tmp_directions.append(mvup_dir)
        tmp_directions.append(mvlf_dir)
        tmp_directions.append(mvrt_dir)
        for index,new in enumerate(tmp_nodes):
            if new:
                new_node_list.append(new)
                new_directions.append(tmp_directions[index])
        return new_node_list,new_directions

    def _heuristic_manhatten(self, node, goal):
        ret = 0
        for i in node:
            # exclude None
            if not i:
                continue
            row_idx, col_idx = self._position_by_value(node, i)
            row_idx_goal, col_idx_goal = self._position_by_value(goal, i)
            ret += abs(row_idx_goal - row_idx) + abs(col_idx_goal - col_idx)
        return ret

    def rep_node(self, node):
        ret = ""
        cells = int(math.sqrt(len(node)))
        for count, val in enumerate(node):
            if not val:
                val = "N"
            if (count + 1) % cells > 0:
                ret += " %s |" % val 
            else:
                ret += " %s\n" % val 
        return ret    

    def astar(self, node_list=None):
        ret = None
        if not node_list:
            self.start.cost = self._heuristic_manhatten(self.start.value, self.goal.value)
            self.start.total_cost  = 0
            node_list = []
            heapq.heapify(node_list)
            heapq.heappush(node_list, self.start)
            visited = []

        while node_list:
            node = heapq.heappop(node_list)

            if node.value == self.goal.value:
                return node

            tmp,directions = self.get_children(node.value)
            for index,choice in enumerate(tmp):
                if choice not in visited:
                    visited.append(choice)
                    obj_node = Node(choice)
                    obj_node.parent = node
                    obj_node.cost = self._heuristic_manhatten(choice, self.goal.value)
                    obj_node.total_cost = obj_node.cost + node.total_cost      
                    obj_node.point_to_childern = directions[index]
                    heapq.heappush(node_list, obj_node)
        return ret
        
class algoNode():
    def __init__(self):
        self.node = None
        self.pub = None
        self.sub = None
        self.start_cond = None
        self.NONE_VALUE = 999
        self.time_stamp = None
        
    def start(self):
        self.node = rospy.init_node('algo_node')
        self.pub = rospy.Publisher('algo_result', String, queue_size=10)
        self.sub = rospy.Subscriber('cam_detected', UIntArray, self.__listenerCallback)
        
    def goal_determine(self):
        if self.start_cond == None:
            return None
        num_sum = 0
        ideal_sum = 45
        goal = [None] * 9
        for num in self.start_cond:
            if not num == None:
                num_sum += num
        lacked_num = ideal_sum - num_sum
        if lacked_num > 9:
            return None
        for i in range(len(self.start_cond)):
            if i == (lacked_num - 1):
                goal[i] = None
            else:
                goal[i] = i + 1
        return goal
        
    def publish(self, actions):
        pub_data =  String() #Need to be specified again
        pub_data.data = actions
        self.pub.publish(pub_data)
        
    def __listenerCallback(self, recieved_data):
        recieved_data_list = list(recieved_data.data)
        recieved_data_list.reverse()
        for index,data in enumerate(recieved_data_list):
            if data == self.NONE_VALUE:
                recieved_data_list[index] = None
        if not self.time_stamp and self.time_stamp == recieved_data.time_stamp:
            return None
        self.start_cond = recieved_data_list
        self.time_stamp = recieved_data.time_stamp
        
    # def get_goal_position(self):
        # rospy.wait_for_service('GetTheGoal')
        # try:
            # service_func = rospy.ServiceProxy('GetTheGoal', goal)
            # return service_func(True)
        # except rospy.ServiceException:
            # rospy.loginfo('Service call failed.')
            
                
   
def main():
    parser = argparse.ArgumentParser()

    parser.add_argument('-a', action="store", dest="algo", default="astar")
    parser.add_argument('-d', action="store", dest="condition", default="start")
    parser.add_argument('-c', action="store", dest="count", type=int, default=1)
    result = parser.parse_args()
    
    #Setup ros node
    ros_node = algoNode()
    ros_node.start()


    while (not rospy.is_shutdown()):
        if ros_node.start_cond == None:
            continue
        goal_cond = ros_node.goal_determine()
        if goal_cond == None:
            continue
        puzzle = PuzzleSearch(Node(ros_node.start_cond), Node(goal_cond))
        
        for i in range(result.count):
            # getattr to get fuction value
            func = getattr(puzzle, result.algo)
            res = func()

         
        order = Queue()
        reorder = Stack()
        node = res
        reorder.push(node.value)
        count = 0
        actions = []

        while True:
            if not node:
                break
            order.push(node.value)
            reorder.push(node.value)
            count +=1          
            if node.point_to_childern == None :
                pass
            else:
                actions.append(node.point_to_childern)
            node = node.parent
            
        actions.reverse()
        actions_string = ",".join(actions)
        print(actions,actions_string)
        ros_node.publish(actions_string)
        
        # movement = count-1
        # order.push(start_cond)
        
        '''
        print ("To solve the puzzle : \n")
        time.sleep(0.75)
        '''
        # for i in range(count):
            # #path = 'output.txt'
            # #with open(path,'a') as f:
            # #f = open(path, 'a')    
            # #num = puzzle.rep_node(reorder.pop())
            # str = puzzle.rep_node(reorder.pop())
            # str = str.replace('N','0')
            # num = [int(temp)for temp in str.split() if temp.isdigit()]
            # print(num)
        # print(actions)
        

        ''' 
        print ("Total movement =  %s\n") % movement
        time.sleep(0.75)
        
        print ("To reverse the puzzle : \n")
        time.sleep(0.75)

        for i in range(count):
            print (puzzle.rep_node(order.pop()))
            time.sleep(0.75)
        '''    
if __name__ == "__main__":
    main()
