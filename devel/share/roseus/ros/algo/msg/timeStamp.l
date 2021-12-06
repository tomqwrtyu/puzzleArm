;; Auto-generated. Do not edit!


(when (boundp 'algo::timeStamp)
  (if (not (find-package "ALGO"))
    (make-package "ALGO"))
  (shadow 'timeStamp (find-package "ALGO")))
(unless (find-package "ALGO::TIMESTAMP")
  (make-package "ALGO::TIMESTAMP"))

(in-package "ROS")
;;//! \htmlinclude timeStamp.msg.html


(defclass algo::timeStamp
  :super ros::object
  :slots (_time_stamp ))

(defmethod algo::timeStamp
  (:init
   (&key
    ((:time_stamp __time_stamp) 0.0)
    )
   (send-super :init)
   (setq _time_stamp (float __time_stamp))
   self)
  (:time_stamp
   (&optional __time_stamp)
   (if __time_stamp (setq _time_stamp __time_stamp)) _time_stamp)
  (:serialization-length
   ()
   (+
    ;; float64 _time_stamp
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _time_stamp
       (sys::poke _time_stamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _time_stamp
     (setq _time_stamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get algo::timeStamp :md5sum-) "1b5e4ee2dd9c99a9b543c72da6261542")
(setf (get algo::timeStamp :datatype-) "algo/timeStamp")
(setf (get algo::timeStamp :definition-)
      "float64 time_stamp





")



(provide :algo/timeStamp "1b5e4ee2dd9c99a9b543c72da6261542")


