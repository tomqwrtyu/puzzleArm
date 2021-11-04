;; Auto-generated. Do not edit!


(when (boundp 'algo::stringArray)
  (if (not (find-package "ALGO"))
    (make-package "ALGO"))
  (shadow 'stringArray (find-package "ALGO")))
(unless (find-package "ALGO::STRINGARRAY")
  (make-package "ALGO::STRINGARRAY"))

(in-package "ROS")
;;//! \htmlinclude stringArray.msg.html


(defclass algo::stringArray
  :super ros::object
  :slots (_time_stamp _data ))

(defmethod algo::stringArray
  (:init
   (&key
    ((:time_stamp __time_stamp) 0.0)
    ((:data __data) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _time_stamp (float __time_stamp))
   (setq _data __data)
   self)
  (:time_stamp
   (&optional __time_stamp)
   (if __time_stamp (setq _time_stamp __time_stamp)) _time_stamp)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:serialization-length
   ()
   (+
    ;; float64 _time_stamp
    8
    ;; string[] _data
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _data)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _time_stamp
       (sys::poke _time_stamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string[] _data
     (write-long (length _data) s)
     (dolist (elem _data)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _time_stamp
     (setq _time_stamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string[] _data
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _data (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _data i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get algo::stringArray :md5sum-) "93db99df41c7f7b2322d7c908b9a2274")
(setf (get algo::stringArray :datatype-) "algo/stringArray")
(setf (get algo::stringArray :definition-)
      "float64 time_stamp
string[] data





")



(provide :algo/stringArray "93db99df41c7f7b2322d7c908b9a2274")


