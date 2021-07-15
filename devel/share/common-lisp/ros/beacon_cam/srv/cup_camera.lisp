; Auto-generated. Do not edit!


(cl:in-package beacon_cam-srv)


;//! \htmlinclude cup_camera-request.msg.html

(cl:defclass <cup_camera-request> (roslisp-msg-protocol:ros-message)
  ((req
    :reader req
    :initarg :req
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass cup_camera-request (<cup_camera-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <cup_camera-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'cup_camera-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name beacon_cam-srv:<cup_camera-request> is deprecated: use beacon_cam-srv:cup_camera-request instead.")))

(cl:ensure-generic-function 'req-val :lambda-list '(m))
(cl:defmethod req-val ((m <cup_camera-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader beacon_cam-srv:req-val is deprecated.  Use beacon_cam-srv:req instead.")
  (req m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <cup_camera-request>) ostream)
  "Serializes a message object of type '<cup_camera-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'req) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <cup_camera-request>) istream)
  "Deserializes a message object of type '<cup_camera-request>"
    (cl:setf (cl:slot-value msg 'req) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<cup_camera-request>)))
  "Returns string type for a service object of type '<cup_camera-request>"
  "beacon_cam/cup_cameraRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'cup_camera-request)))
  "Returns string type for a service object of type 'cup_camera-request"
  "beacon_cam/cup_cameraRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<cup_camera-request>)))
  "Returns md5sum for a message object of type '<cup_camera-request>"
  "7a20991e451c1198c7723ab0b4776fd9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'cup_camera-request)))
  "Returns md5sum for a message object of type 'cup_camera-request"
  "7a20991e451c1198c7723ab0b4776fd9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<cup_camera-request>)))
  "Returns full string definition for message of type '<cup_camera-request>"
  (cl:format cl:nil "bool req~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'cup_camera-request)))
  "Returns full string definition for message of type 'cup_camera-request"
  (cl:format cl:nil "bool req~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <cup_camera-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <cup_camera-request>))
  "Converts a ROS message object to a list"
  (cl:list 'cup_camera-request
    (cl:cons ':req (req msg))
))
;//! \htmlinclude cup_camera-response.msg.html

(cl:defclass <cup_camera-response> (roslisp-msg-protocol:ros-message)
  ((color
    :reader color
    :initarg :color
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (cup_pos
    :reader cup_pos
    :initarg :cup_pos
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass cup_camera-response (<cup_camera-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <cup_camera-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'cup_camera-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name beacon_cam-srv:<cup_camera-response> is deprecated: use beacon_cam-srv:cup_camera-response instead.")))

(cl:ensure-generic-function 'color-val :lambda-list '(m))
(cl:defmethod color-val ((m <cup_camera-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader beacon_cam-srv:color-val is deprecated.  Use beacon_cam-srv:color instead.")
  (color m))

(cl:ensure-generic-function 'cup_pos-val :lambda-list '(m))
(cl:defmethod cup_pos-val ((m <cup_camera-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader beacon_cam-srv:cup_pos-val is deprecated.  Use beacon_cam-srv:cup_pos instead.")
  (cup_pos m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <cup_camera-response>) ostream)
  "Serializes a message object of type '<cup_camera-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'color))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'color))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'cup_pos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'cup_pos))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <cup_camera-response>) istream)
  "Deserializes a message object of type '<cup_camera-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'color) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'color)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'cup_pos) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'cup_pos)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<cup_camera-response>)))
  "Returns string type for a service object of type '<cup_camera-response>"
  "beacon_cam/cup_cameraResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'cup_camera-response)))
  "Returns string type for a service object of type 'cup_camera-response"
  "beacon_cam/cup_cameraResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<cup_camera-response>)))
  "Returns md5sum for a message object of type '<cup_camera-response>"
  "7a20991e451c1198c7723ab0b4776fd9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'cup_camera-response)))
  "Returns md5sum for a message object of type 'cup_camera-response"
  "7a20991e451c1198c7723ab0b4776fd9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<cup_camera-response>)))
  "Returns full string definition for message of type '<cup_camera-response>"
  (cl:format cl:nil "int32[] color~%float32[] cup_pos~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'cup_camera-response)))
  "Returns full string definition for message of type 'cup_camera-response"
  (cl:format cl:nil "int32[] color~%float32[] cup_pos~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <cup_camera-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'color) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'cup_pos) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <cup_camera-response>))
  "Converts a ROS message object to a list"
  (cl:list 'cup_camera-response
    (cl:cons ':color (color msg))
    (cl:cons ':cup_pos (cup_pos msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'cup_camera)))
  'cup_camera-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'cup_camera)))
  'cup_camera-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'cup_camera)))
  "Returns string type for a service object of type '<cup_camera>"
  "beacon_cam/cup_camera")