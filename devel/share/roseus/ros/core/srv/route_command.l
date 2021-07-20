;; Auto-generated. Do not edit!


(when (boundp 'core::route_command)
  (if (not (find-package "CORE"))
    (make-package "CORE"))
  (shadow 'route_command (find-package "CORE")))
(unless (find-package "CORE::ROUTE_COMMAND")
  (make-package "CORE::ROUTE_COMMAND"))
(unless (find-package "CORE::ROUTE_COMMANDREQUEST")
  (make-package "CORE::ROUTE_COMMANDREQUEST"))
(unless (find-package "CORE::ROUTE_COMMANDRESPONSE")
  (make-package "CORE::ROUTE_COMMANDRESPONSE"))

(in-package "ROS")





(defclass core::route_commandRequest
  :super ros::object
  :slots (_route ))

(defmethod core::route_commandRequest
  (:init
   (&key
    ((:route __route) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _route __route)
   self)
  (:route
   (&optional __route)
   (if __route (setq _route __route)) _route)
  (:serialization-length
   ()
   (+
    ;; int32[] _route
    (* 4    (length _route)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32[] _route
     (write-long (length _route) s)
     (dotimes (i (length _route))
       (write-long (elt _route i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32[] _route
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _route (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _route i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(defclass core::route_commandResponse
  :super ros::object
  :slots (_stm_state ))

(defmethod core::route_commandResponse
  (:init
   (&key
    ((:stm_state __stm_state) 0)
    )
   (send-super :init)
   (setq _stm_state (round __stm_state))
   self)
  (:stm_state
   (&optional __stm_state)
   (if __stm_state (setq _stm_state __stm_state)) _stm_state)
  (:serialization-length
   ()
   (+
    ;; uint8 _stm_state
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _stm_state
       (write-byte _stm_state s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _stm_state
     (setq _stm_state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass core::route_command
  :super ros::object
  :slots ())

(setf (get core::route_command :md5sum-) "e934608428f4a678bcc6b43ef7249b80")
(setf (get core::route_command :datatype-) "core/route_command")
(setf (get core::route_command :request) core::route_commandRequest)
(setf (get core::route_command :response) core::route_commandResponse)

(defmethod core::route_commandRequest
  (:response () (instance core::route_commandResponse :init)))

(setf (get core::route_commandRequest :md5sum-) "e934608428f4a678bcc6b43ef7249b80")
(setf (get core::route_commandRequest :datatype-) "core/route_commandRequest")
(setf (get core::route_commandRequest :definition-)
      "int32[] route
---
uint8 stm_state



")

(setf (get core::route_commandResponse :md5sum-) "e934608428f4a678bcc6b43ef7249b80")
(setf (get core::route_commandResponse :datatype-) "core/route_commandResponse")
(setf (get core::route_commandResponse :definition-)
      "int32[] route
---
uint8 stm_state



")



(provide :core/route_command "e934608428f4a678bcc6b43ef7249b80")


