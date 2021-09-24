;; Auto-generated. Do not edit!


(when (boundp 'cam::goal)
  (if (not (find-package "CAM"))
    (make-package "CAM"))
  (shadow 'goal (find-package "CAM")))
(unless (find-package "CAM::GOAL")
  (make-package "CAM::GOAL"))
(unless (find-package "CAM::GOALREQUEST")
  (make-package "CAM::GOALREQUEST"))
(unless (find-package "CAM::GOALRESPONSE")
  (make-package "CAM::GOALRESPONSE"))

(in-package "ROS")





(defclass cam::goalRequest
  :super ros::object
  :slots (_req ))

(defmethod cam::goalRequest
  (:init
   (&key
    ((:req __req) nil)
    )
   (send-super :init)
   (setq _req __req)
   self)
  (:req
   (&optional __req)
   (if __req (setq _req __req)) _req)
  (:serialization-length
   ()
   (+
    ;; bool _req
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _req
       (if _req (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _req
     (setq _req (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass cam::goalResponse
  :super ros::object
  :slots (_goal_pos ))

(defmethod cam::goalResponse
  (:init
   (&key
    ((:goal_pos __goal_pos) 0)
    )
   (send-super :init)
   (setq _goal_pos (round __goal_pos))
   self)
  (:goal_pos
   (&optional __goal_pos)
   (if __goal_pos (setq _goal_pos __goal_pos)) _goal_pos)
  (:serialization-length
   ()
   (+
    ;; int32 _goal_pos
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _goal_pos
       (write-long _goal_pos s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _goal_pos
     (setq _goal_pos (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass cam::goal
  :super ros::object
  :slots ())

(setf (get cam::goal :md5sum-) "2ceead7433605f9dde8aff8b1e4a54fc")
(setf (get cam::goal :datatype-) "cam/goal")
(setf (get cam::goal :request) cam::goalRequest)
(setf (get cam::goal :response) cam::goalResponse)

(defmethod cam::goalRequest
  (:response () (instance cam::goalResponse :init)))

(setf (get cam::goalRequest :md5sum-) "2ceead7433605f9dde8aff8b1e4a54fc")
(setf (get cam::goalRequest :datatype-) "cam/goalRequest")
(setf (get cam::goalRequest :definition-)
      "bool req
---
int32 goal_pos





")

(setf (get cam::goalResponse :md5sum-) "2ceead7433605f9dde8aff8b1e4a54fc")
(setf (get cam::goalResponse :datatype-) "cam/goalResponse")
(setf (get cam::goalResponse :definition-)
      "bool req
---
int32 goal_pos





")



(provide :cam/goal "2ceead7433605f9dde8aff8b1e4a54fc")


