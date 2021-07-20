;; Auto-generated. Do not edit!


(when (boundp 'algo::num_state)
  (if (not (find-package "ALGO"))
    (make-package "ALGO"))
  (shadow 'num_state (find-package "ALGO")))
(unless (find-package "ALGO::NUM_STATE")
  (make-package "ALGO::NUM_STATE"))
(unless (find-package "ALGO::NUM_STATEREQUEST")
  (make-package "ALGO::NUM_STATEREQUEST"))
(unless (find-package "ALGO::NUM_STATERESPONSE")
  (make-package "ALGO::NUM_STATERESPONSE"))

(in-package "ROS")





(defclass algo::num_stateRequest
  :super ros::object
  :slots (_num_state ))

(defmethod algo::num_stateRequest
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

(defclass algo::num_stateResponse
  :super ros::object
  :slots (_req ))

(defmethod algo::num_stateResponse
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

(defclass algo::num_state
  :super ros::object
  :slots ())

(setf (get algo::num_state :md5sum-) "3ef8d46e3fcd35484b18eba316522655")
(setf (get algo::num_state :datatype-) "algo/num_state")
(setf (get algo::num_state :request) algo::num_stateRequest)
(setf (get algo::num_state :response) algo::num_stateResponse)

(defmethod algo::num_stateRequest
  (:response () (instance algo::num_stateResponse :init)))

(setf (get algo::num_stateRequest :md5sum-) "3ef8d46e3fcd35484b18eba316522655")
(setf (get algo::num_stateRequest :datatype-) "algo/num_stateRequest")
(setf (get algo::num_stateRequest :definition-)
      "int32[] num_state
---
bool req



")

(setf (get algo::num_stateResponse :md5sum-) "3ef8d46e3fcd35484b18eba316522655")
(setf (get algo::num_stateResponse :datatype-) "algo/num_stateResponse")
(setf (get algo::num_stateResponse :definition-)
      "int32[] num_state
---
bool req



")



(provide :algo/num_state "3ef8d46e3fcd35484b18eba316522655")


