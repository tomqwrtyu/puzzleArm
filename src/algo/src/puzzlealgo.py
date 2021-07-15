import sys
import copy
import time
import math
# heapq is similar to priorty queue
import heapq
import argparse
import time


GOAL = [1, 2, 3, 
        4, 5, 6, 
        7, 8, None]

START1 = [None, 3, 7, 
         1, 2, 8, 
         5, 6, 4]

START = [1, 2, 3, 
        None, 5, 6, 
        4,7, 8]

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

    def __repr__(self):
        return str(self.value)

    def __le__(self, other):
        return self.total_cost <= other.total_cost

class PuzzleSearch(object):

    def __init__(self, start, goal):
        self.start = start
        self.goal = goal
        self.nodes = []


    def _position_by_value(self, node, value):
        cells = int(math.sqrt(len(node)))
        row_idx = node.index(value) / cells
        col_idx = node.index(value) % cells
        return row_idx, col_idx

    def _move_left(self, node):
        row_idx, col_idx = self._position_by_value(node, None)
        cells = int(math.sqrt(len(node)))
        if col_idx != 0:
            newnode = copy.deepcopy(node)
            idx_old = cells * row_idx + col_idx
            idx_new = cells * row_idx + col_idx-1
            new_val = node[idx_new]
            newnode[idx_old] = new_val
            newnode[idx_new] = None
            return newnode

    def _move_right(self, node):
        row_idx, col_idx = self._position_by_value(node, None)
        cells = int(math.sqrt(len(node)))
        max_col = cells-1
        if col_idx != max_col:
            newnode = copy.deepcopy(node)
            idx_old = cells * row_idx + col_idx
            idx_new = cells * row_idx + col_idx+1
            new_val = node[idx_new]
            newnode[idx_old] = new_val
            newnode[idx_new] = None
            return newnode

    def _move_up(self, node):
        row_idx, col_idx = self._position_by_value(node, None)
        cells = int(math.sqrt(len(node)))
        if row_idx != 0:
            newnode = copy.deepcopy(node)
            idx_old = cells * row_idx + col_idx
            idx_new = cells * (row_idx-1) + col_idx
            new_val = node[idx_new]
            newnode[idx_old] = new_val
            newnode[idx_new] = None
            return newnode

    def _move_down(self, node):
        row_idx, col_idx = self._position_by_value(node, None)
        cells = int(math.sqrt(len(node)))
        max_row = cells-1
        if row_idx != max_row:
            newnode = copy.deepcopy(node)
            idx_old = cells * row_idx + col_idx
            idx_new = cells * (row_idx+1) + col_idx
            new_val = node[idx_new]
            newnode[idx_old] = new_val
            newnode[idx_new] = None
            return newnode

    def get_children(self, node):
        tmp_nodes = []
        new_node_list = []
        tmp_nodes.append(self._move_down(node))
        tmp_nodes.append(self._move_up(node))
        tmp_nodes.append(self._move_left(node))
        tmp_nodes.append(self._move_right(node))
        for new in tmp_nodes:
            if new:
                new_node_list.append(new)
        return new_node_list

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
            self.start.cost = self._heuristic_manhatten(self.start.value, 
                    self.goal.value)
            self.start.total_cost  = 0
            node_list = []
            heapq.heapify(node_list)
            heapq.heappush(node_list, self.start)
            visited = []
        
        while node_list:
            node = heapq.heappop(node_list)

            if node.value == self.goal.value:
                return node

            tmp = self.get_children(node.value)
            for i in tmp:
                if i not in visited:
                    visited.append(i)
                    obj_node = Node(i)
                    obj_node.parent = node
                    obj_node.cost = self._heuristic_manhatten(i, self.goal.value)
                    obj_node.total_cost = obj_node.cost + node.total_cost
                    heapq.heappush(node_list, obj_node)
        return ret

if __name__ == "__main__":

    parser = argparse.ArgumentParser()

    parser.add_argument('-a', action="store", dest="algo", default="astar")
    parser.add_argument('-d', action="store", dest="condition", default="start")
    parser.add_argument('-c', action="store", dest="count", type=int, default=1)
    result = parser.parse_args()


    if result.algo in ("astar"):
        START = START_DICT.get(result.condition) 
        puzzle = PuzzleSearch(Node(START), Node(GOAL))
        
        for i in range(result.count):
            # getattr to get fuction value
            func = getattr(puzzle, result.algo)
            res = func()
        
        order = Queue()
        reorder = Stack()
        node = res
        reorder.push(node.value)
        count = 0

        while True:
            if not node:
                break
            order.push(node.value)
            reorder.push(node.value)
            count +=1
            node = node.parent
        
        movement = count-1
        order.push(START)
        
        print ("To solve the puzzle : \n")
        time.sleep(0.75)
        for i in range(count):
            print (puzzle.rep_node(reorder.pop()))
            time.sleep(0.75)

        print ("Total movement =  %s\n") % movement
        time.sleep(0.75)

        print ("To reverse the puzzle : \n")
        time.sleep(0.75)

        for i in range(count):
            print (puzzle.rep_node(order.pop()))
            time.sleep(0.75)
        