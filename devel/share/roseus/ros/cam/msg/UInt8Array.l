;; Auto-generated. Do not edit!


(when (boundp 'cam::UInt8Array)
  (if (not (find-package "CAM"))
    (make-package "CAM"))
  (shadow 'UInt8Array (find-package "CAM")))
(unless (find-package "CAM::UINT8ARRAY")
  (make-package "CAM::UINT8ARRAY"))

(in-package "ROS")
;;//! \htmlinclude UInt8Array.msg.html


(defclass cam::UInt8Array
  :super ros::object
  :slots (_time_stamp _data ))

(defmethod cam::UInt8Array
  (:init
   (&key
    ((:time_stamp __time_stamp) 0.0)
    ((:data __data) (make-array 0 :initial-element 0 :element-type :char))
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
    ;; float32 _time_stamp
    4
    ;; uint8[] _data
    (* 1    (length _data)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _time_stamp
       (sys::poke _time_stamp (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8[] _data
     (write-long (length _data) s)
     (princ _data s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _time_stamp
     (setq _time_stamp (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8[] _data
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _data (make-array n :element-type :char))
     (replace _data buf :start2 ptr-) (incf ptr- n))
   ;;
   self)
  )

(setf (get cam::UInt8Array :md5sum-) "83877a2239ce387d8af9561bf045b66c")
(setf (get cam::UInt8Array :datatype-) "cam/UInt8Array")
(setf (get cam::UInt8Array :definition-)
      "float32 time_stamp
uint8[] data





")



(provide :cam/UInt8Array "83877a2239ce387d8af9561bf045b66c")


