; Auto-generated. Do not edit!


(cl:in-package beacon_cam-srv)


;//! \htmlinclude point_transform-request.msg.html

(cl:defclass <point_transform-request> (roslisp-msg-protocol:ros-message)
  ((cp_pos
    :reader cp_pos
    :initarg :cp_pos
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass point_transform-request (<point_transform-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <point_transform-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'point_transform-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name beacon_cam-srv:<point_transform-request> is deprecated: use beacon_cam-srv:point_transform-request instead.")))

(cl:ensure-generic-function 'cp_pos-val :lambda-list '(m))
(cl:defmethod cp_pos-val ((m <point_transform-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader beacon_cam-srv:cp_pos-val is deprecated.  Use beacon_cam-srv:cp_pos instead.")
  (cp_pos m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <point_transform-request>) ostream)
  "Serializes a message object of type '<point_transform-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'cp_pos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'cp_pos))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <point_transform-request>) istream)
  "Deserializes a message object of type '<point_transform-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'cp_pos) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'cp_pos)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<point_transform-request>)))
  "Returns string type for a service object of type '<point_transform-request>"
  "beacon_cam/point_transformRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'point_transform-request)))
  "Returns string type for a service object of type 'point_transform-request"
  "beacon_cam/point_transformRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<point_transform-request>)))
  "Returns md5sum for a message object of type '<point_transform-request>"
  "7e85000443f684022e3afc6d15f3d299")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'point_transform-request)))
  "Returns md5sum for a message object of type 'point_transform-request"
  "7e85000443f684022e3afc6d15f3d299")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<point_transform-request>)))
  "Returns full string definition for message of type '<point_transform-request>"
  (cl:format cl:nil "float32[] cp_pos~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'point_transform-request)))
  "Returns full string definition for message of type 'point_transform-request"
  (cl:format cl:nil "float32[] cp_pos~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <point_transform-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'cp_pos) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <point_transform-request>))
  "Converts a ROS message object to a list"
  (cl:list 'point_transform-request
    (cl:cons ':cp_pos (cp_pos msg))
))
;//! \htmlinclude point_transform-response.msg.html

(cl:defclass <point_transform-response> (roslisp-msg-protocol:ros-message)
  ((tf_pos
    :reader tf_pos
    :initarg :tf_pos
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass point_transform-response (<point_transform-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <point_transform-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'point_transform-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name beacon_cam-srv:<point_transform-response> is deprecated: use beacon_cam-srv:point_transform-response instead.")))

(cl:ensure-generic-function 'tf_pos-val :lambda-list '(m))
(cl:defmethod tf_pos-val ((m <point_transform-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader beacon_cam-srv:tf_pos-val is deprecated.  Use beacon_cam-srv:tf_pos instead.")
  (tf_pos m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <point_transform-response>) ostream)
  "Serializes a message object of type '<point_transform-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tf_pos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'tf_pos))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <point_transform-response>) istream)
  "Deserializes a message object of type '<point_transform-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'tf_pos) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'tf_pos)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<point_transform-response>)))
  "Returns string type for a service object of type '<point_transform-response>"
  "beacon_cam/point_transformResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'point_transform-response)))
  "Returns string type for a service object of type 'point_transform-response"
  "beacon_cam/point_transformResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<point_transform-response>)))
  "Returns md5sum for a message object of type '<point_transform-response>"
  "7e85000443f684022e3afc6d15f3d299")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'point_transform-response)))
  "Returns md5sum for a message object of type 'point_transform-response"
  "7e85000443f684022e3afc6d15f3d299")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<point_transform-response>)))
  "Returns full string definition for message of type '<point_transform-response>"
  (cl:format cl:nil "float32[] tf_pos~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'point_transform-response)))
  "Returns full string definition for message of type 'point_transform-response"
  (cl:format cl:nil "float32[] tf_pos~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <point_transform-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tf_pos) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <point_transform-response>))
  "Converts a ROS message object to a list"
  (cl:list 'point_transform-response
    (cl:cons ':tf_pos (tf_pos msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'point_transform)))
  'point_transform-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'point_transform)))
  'point_transform-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'point_transform)))
  "Returns string type for a service object of type '<point_transform>"
  "beacon_cam/point_transform")