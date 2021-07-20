; Auto-generated. Do not edit!


(cl:in-package core-srv)


;//! \htmlinclude route_command-request.msg.html

(cl:defclass <route_command-request> (roslisp-msg-protocol:ros-message)
  ((route
    :reader route
    :initarg :route
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass route_command-request (<route_command-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <route_command-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'route_command-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name core-srv:<route_command-request> is deprecated: use core-srv:route_command-request instead.")))

(cl:ensure-generic-function 'route-val :lambda-list '(m))
(cl:defmethod route-val ((m <route_command-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader core-srv:route-val is deprecated.  Use core-srv:route instead.")
  (route m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <route_command-request>) ostream)
  "Serializes a message object of type '<route_command-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'route))))
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
   (cl:slot-value msg 'route))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <route_command-request>) istream)
  "Deserializes a message object of type '<route_command-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'route) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'route)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<route_command-request>)))
  "Returns string type for a service object of type '<route_command-request>"
  "core/route_commandRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'route_command-request)))
  "Returns string type for a service object of type 'route_command-request"
  "core/route_commandRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<route_command-request>)))
  "Returns md5sum for a message object of type '<route_command-request>"
  "e934608428f4a678bcc6b43ef7249b80")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'route_command-request)))
  "Returns md5sum for a message object of type 'route_command-request"
  "e934608428f4a678bcc6b43ef7249b80")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<route_command-request>)))
  "Returns full string definition for message of type '<route_command-request>"
  (cl:format cl:nil "int32[] route~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'route_command-request)))
  "Returns full string definition for message of type 'route_command-request"
  (cl:format cl:nil "int32[] route~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <route_command-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'route) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <route_command-request>))
  "Converts a ROS message object to a list"
  (cl:list 'route_command-request
    (cl:cons ':route (route msg))
))
;//! \htmlinclude route_command-response.msg.html

(cl:defclass <route_command-response> (roslisp-msg-protocol:ros-message)
  ((stm_state
    :reader stm_state
    :initarg :stm_state
    :type cl:fixnum
    :initform 0))
)

(cl:defclass route_command-response (<route_command-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <route_command-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'route_command-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name core-srv:<route_command-response> is deprecated: use core-srv:route_command-response instead.")))

(cl:ensure-generic-function 'stm_state-val :lambda-list '(m))
(cl:defmethod stm_state-val ((m <route_command-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader core-srv:stm_state-val is deprecated.  Use core-srv:stm_state instead.")
  (stm_state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <route_command-response>) ostream)
  "Serializes a message object of type '<route_command-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'stm_state)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <route_command-response>) istream)
  "Deserializes a message object of type '<route_command-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'stm_state)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<route_command-response>)))
  "Returns string type for a service object of type '<route_command-response>"
  "core/route_commandResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'route_command-response)))
  "Returns string type for a service object of type 'route_command-response"
  "core/route_commandResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<route_command-response>)))
  "Returns md5sum for a message object of type '<route_command-response>"
  "e934608428f4a678bcc6b43ef7249b80")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'route_command-response)))
  "Returns md5sum for a message object of type 'route_command-response"
  "e934608428f4a678bcc6b43ef7249b80")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<route_command-response>)))
  "Returns full string definition for message of type '<route_command-response>"
  (cl:format cl:nil "uint8 stm_state~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'route_command-response)))
  "Returns full string definition for message of type 'route_command-response"
  (cl:format cl:nil "uint8 stm_state~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <route_command-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <route_command-response>))
  "Converts a ROS message object to a list"
  (cl:list 'route_command-response
    (cl:cons ':stm_state (stm_state msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'route_command)))
  'route_command-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'route_command)))
  'route_command-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'route_command)))
  "Returns string type for a service object of type '<route_command>"
  "core/route_command")