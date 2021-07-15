;; Auto-generated. Do not edit!


(when (boundp 'beacon_cam::cup_camera)
  (if (not (find-package "BEACON_CAM"))
    (make-package "BEACON_CAM"))
  (shadow 'cup_camera (find-package "BEACON_CAM")))
(unless (find-package "BEACON_CAM::CUP_CAMERA")
  (make-package "BEACON_CAM::CUP_CAMERA"))
(unless (find-package "BEACON_CAM::CUP_CAMERAREQUEST")
  (make-package "BEACON_CAM::CUP_CAMERAREQUEST"))
(unless (find-package "BEACON_CAM::CUP_CAMERARESPONSE")
  (make-package "BEACON_CAM::CUP_CAMERARESPONSE"))

(in-package "ROS")





(defclass beacon_cam::cup_cameraRequest
  :super ros::object
  :slots (_req ))

(defmethod beacon_cam::cup_cameraRequest
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

(defclass beacon_cam::cup_cameraResponse
  :super ros::object
  :slots (_color _cup_pos ))

(defmethod beacon_cam::cup_cameraResponse
  (:init
   (&key
    ((:color __color) (make-array 0 :initial-element 0 :element-type :integer))
    ((:cup_pos __cup_pos) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _color __color)
   (setq _cup_pos __cup_pos)
   self)
  (:color
   (&optional __color)
   (if __color (setq _color __color)) _color)
  (:cup_pos
   (&optional __cup_pos)
   (if __cup_pos (setq _cup_pos __cup_pos)) _cup_pos)
  (:serialization-length
   ()
   (+
    ;; int32[] _color
    (* 4    (length _color)) 4
    ;; float32[] _cup_pos
    (* 4    (length _cup_pos)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32[] _color
     (write-long (length _color) s)
     (dotimes (i (length _color))
       (write-long (elt _color i) s)
       )
     ;; float32[] _cup_pos
     (write-long (length _cup_pos) s)
     (dotimes (i (length _cup_pos))
       (sys::poke (elt _cup_pos i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32[] _color
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _color (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _color i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; float32[] _cup_pos
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _cup_pos (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _cup_pos i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(defclass beacon_cam::cup_camera
  :super ros::object
  :slots ())

(setf (get beacon_cam::cup_camera :md5sum-) "7a20991e451c1198c7723ab0b4776fd9")
(setf (get beacon_cam::cup_camera :datatype-) "beacon_cam/cup_camera")
(setf (get beacon_cam::cup_camera :request) beacon_cam::cup_cameraRequest)
(setf (get beacon_cam::cup_camera :response) beacon_cam::cup_cameraResponse)

(defmethod beacon_cam::cup_cameraRequest
  (:response () (instance beacon_cam::cup_cameraResponse :init)))

(setf (get beacon_cam::cup_cameraRequest :md5sum-) "7a20991e451c1198c7723ab0b4776fd9")
(setf (get beacon_cam::cup_cameraRequest :datatype-) "beacon_cam/cup_cameraRequest")
(setf (get beacon_cam::cup_cameraRequest :definition-)
      "bool req
---
int32[] color
float32[] cup_pos



")

(setf (get beacon_cam::cup_cameraResponse :md5sum-) "7a20991e451c1198c7723ab0b4776fd9")
(setf (get beacon_cam::cup_cameraResponse :datatype-) "beacon_cam/cup_cameraResponse")
(setf (get beacon_cam::cup_cameraResponse :definition-)
      "bool req
---
int32[] color
float32[] cup_pos



")



(provide :beacon_cam/cup_camera "7a20991e451c1198c7723ab0b4776fd9")


