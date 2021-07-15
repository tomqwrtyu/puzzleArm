;; Auto-generated. Do not edit!


(when (boundp 'cam::num_state)
  (if (not (find-package "CAM"))
    (make-package "CAM"))
  (shadow 'num_state (find-package "CAM")))
(unless (find-package "CAM::NUM_STATE")
  (make-package "CAM::NUM_STATE"))
(unless (find-package "CAM::NUM_STATEREQUEST")
  (make-package "CAM::NUM_STATEREQUEST"))
(unless (find-package "CAM::NUM_STATERESPONSE")
  (make-package "CAM::NUM_STATERESPONSE"))

(in-package "ROS")





(defclass cam::num_stateRequest
  :super ros::object
  :slots (_num_state ))

(defmethod cam::num_stateRequest
  (:init
   (&key
    ((:num_state __num_state) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _num_state __num_state)
   self)
  (:num_state
   (&optional __num_state)
   (if __num_state (setq _num_state __num_state)) _num_state)
  (:serialization-length
   ()
   (+
    ;; int32[] _num_state
    (* 4    (length _num_state)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32[] _num_state
     (write-long (length _num_state) s)
     (dotimes (i (length _num_state))
       (write-long (elt _num_state i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32[] _num_state
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _num_state (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _num_state i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(defclass cam::num_stateResponse
  :super ros::object
  :slots (_req ))

(defmethod cam::num_stateResponse
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

(defclass cam::num_state
  :super ros::object
  :slots ())

(setf (get cam::num_state :md5sum-) "3ef8d46e3fcd35484b18eba316522655")
(setf (get cam::num_state :datatype-) "cam/num_state")
(setf (get cam::num_state :request) cam::num_stateRequest)
(setf (get cam::num_state :response) cam::num_stateResponse)

(defmethod cam::num_stateRequest
  (:response () (instance cam::num_stateResponse :init)))

(setf (get cam::num_stateRequest :md5sum-) "3ef8d46e3fcd35484b18eba316522655")
(setf (get cam::num_stateRequest :datatype-) "cam/num_stateRequest")
(setf (get cam::num_stateRequest :definition-)
      "int32[] num_state
---
bool req



")

(setf (get cam::num_stateResponse :md5sum-) "3ef8d46e3fcd35484b18eba316522655")
(setf (get cam::num_stateResponse :datatype-) "cam/num_stateResponse")
(setf (get cam::num_stateResponse :definition-)
      "int32[] num_state
---
bool req



")



(provide :cam/num_state "3ef8d46e3fcd35484b18eba316522655")


