;; Auto-generated. Do not edit!


(when (boundp 'beacon_cam::point_transform)
  (if (not (find-package "BEACON_CAM"))
    (make-package "BEACON_CAM"))
  (shadow 'point_transform (find-package "BEACON_CAM")))
(unless (find-package "BEACON_CAM::POINT_TRANSFORM")
  (make-package "BEACON_CAM::POINT_TRANSFORM"))
(unless (find-package "BEACON_CAM::POINT_TRANSFORMREQUEST")
  (make-package "BEACON_CAM::POINT_TRANSFORMREQUEST"))
(unless (find-package "BEACON_CAM::POINT_TRANSFORMRESPONSE")
  (make-package "BEACON_CAM::POINT_TRANSFORMRESPONSE"))

(in-package "ROS")





(defclass beacon_cam::point_transformRequest
  :super ros::object
  :slots (_cp_pos ))

(defmethod beacon_cam::point_transformRequest
  (:init
   (&key
    ((:cp_pos __cp_pos) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _cp_pos __cp_pos)
   self)
  (:cp_pos
   (&optional __cp_pos)
   (if __cp_pos (setq _cp_pos __cp_pos)) _cp_pos)
  (:serialization-length
   ()
   (+
    ;; float32[] _cp_pos
    (* 4    (length _cp_pos)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32[] _cp_pos
     (write-long (length _cp_pos) s)
     (dotimes (i (length _cp_pos))
       (sys::poke (elt _cp_pos i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32[] _cp_pos
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _cp_pos (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _cp_pos i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(defclass beacon_cam::point_transformResponse
  :super ros::object
  :slots (_tf_pos ))

(defmethod beacon_cam::point_transformResponse
  (:init
   (&key
    ((:tf_pos __tf_pos) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _tf_pos __tf_pos)
   self)
  (:tf_pos
   (&optional __tf_pos)
   (if __tf_pos (setq _tf_pos __tf_pos)) _tf_pos)
  (:serialization-length
   ()
   (+
    ;; float32[] _tf_pos
    (* 4    (length _tf_pos)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32[] _tf_pos
     (write-long (length _tf_pos) s)
     (dotimes (i (length _tf_pos))
       (sys::poke (elt _tf_pos i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32[] _tf_pos
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tf_pos (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _tf_pos i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(defclass beacon_cam::point_transform
  :super ros::object
  :slots ())

(setf (get beacon_cam::point_transform :md5sum-) "7e85000443f684022e3afc6d15f3d299")
(setf (get beacon_cam::point_transform :datatype-) "beacon_cam/point_transform")
(setf (get beacon_cam::point_transform :request) beacon_cam::point_transformRequest)
(setf (get beacon_cam::point_transform :response) beacon_cam::point_transformResponse)

(defmethod beacon_cam::point_transformRequest
  (:response () (instance beacon_cam::point_transformResponse :init)))

(setf (get beacon_cam::point_transformRequest :md5sum-) "7e85000443f684022e3afc6d15f3d299")
(setf (get beacon_cam::point_transformRequest :datatype-) "beacon_cam/point_transformRequest")
(setf (get beacon_cam::point_transformRequest :definition-)
      "float32[] cp_pos
---
float32[] tf_pos



")

(setf (get beacon_cam::point_transformResponse :md5sum-) "7e85000443f684022e3afc6d15f3d299")
(setf (get beacon_cam::point_transformResponse :datatype-) "beacon_cam/point_transformResponse")
(setf (get beacon_cam::point_transformResponse :definition-)
      "float32[] cp_pos
---
float32[] tf_pos



")



(provide :beacon_cam/point_transform "7e85000443f684022e3afc6d15f3d299")


