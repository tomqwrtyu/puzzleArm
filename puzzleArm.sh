#Used for launch all files of puzzle solving arm
#!/bin/bash

killall -9 roscore
killall -9 rosmaster
roscore&rosrun cam ros_trt_yolo.py&rosrun algo puzzlealgo.py&rosrun arm ROS_STM.py
wait
