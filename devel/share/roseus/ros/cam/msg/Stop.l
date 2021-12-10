;; Auto-generated. Do not edit!


(when (boundp 'cam::Stop)
  (if (not (find-package "CAM"))
    (make-package "CAM"))
  (shadow 'Stop (find-package "CAM")))
(unless (find-package "CAM::STOP")
  (make-package "CAM::STOP"))

(in-package "ROS")
;;//! \htmlinclude Stop.msg.html


(defclass cam::Stop
  :super ros::object
  :slots (_flag ))

(defmethod cam::Stop
  (:init
   (&key
    ((:flag __flag) nil)
    )
   (send-super :init)
   (setq _flag __flag)
   self)
  (:flag
   (&optional __flag)
   (if __flag (setq _flag __flag)) _flag)
  (:serialization-length
   ()
   (+
    ;; bool _flag
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _flag
       (if _flag (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _flag
     (setq _flag (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get cam::Stop :md5sum-) "24842bc754e0f5cc982338eca1269251")
(setf (get cam::Stop :datatype-) "cam/Stop")
(setf (get cam::Stop :definition-)
      "bool flag

")



(provide :cam/Stop "24842bc754e0f5cc982338eca1269251")


