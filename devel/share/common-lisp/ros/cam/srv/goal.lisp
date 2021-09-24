; Auto-generated. Do not edit!


(cl:in-package cam-srv)


;//! \htmlinclude goal-request.msg.html

(cl:defclass <goal-request> (roslisp-msg-protocol:ros-message)
  ((req
    :reader req
    :initarg :req
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass goal-request (<goal-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goal-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goal-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name cam-srv:<goal-request> is deprecated: use cam-srv:goal-request instead.")))

(cl:ensure-generic-function 'req-val :lambda-list '(m))
(cl:defmethod req-val ((m <goal-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cam-srv:req-val is deprecated.  Use cam-srv:req instead.")
  (req m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goal-request>) ostream)
  "Serializes a message object of type '<goal-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'req) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goal-request>) istream)
  "Deserializes a message object of type '<goal-request>"
    (cl:setf (cl:slot-value msg 'req) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goal-request>)))
  "Returns string type for a service object of type '<goal-request>"
  "cam/goalRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goal-request)))
  "Returns string type for a service object of type 'goal-request"
  "cam/goalRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goal-request>)))
  "Returns md5sum for a message object of type '<goal-request>"
  "2ceead7433605f9dde8aff8b1e4a54fc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goal-request)))
  "Returns md5sum for a message object of type 'goal-request"
  "2ceead7433605f9dde8aff8b1e4a54fc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goal-request>)))
  "Returns full string definition for message of type '<goal-request>"
  (cl:format cl:nil "bool req~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goal-request)))
  "Returns full string definition for message of type 'goal-request"
  (cl:format cl:nil "bool req~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goal-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goal-request>))
  "Converts a ROS message object to a list"
  (cl:list 'goal-request
    (cl:cons ':req (req msg))
))
;//! \htmlinclude goal-response.msg.html

(cl:defclass <goal-response> (roslisp-msg-protocol:ros-message)
  ((goal_pos
    :reader goal_pos
    :initarg :goal_pos
    :type cl:integer
    :initform 0))
)

(cl:defclass goal-response (<goal-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goal-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goal-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name cam-srv:<goal-response> is deprecated: use cam-srv:goal-response instead.")))

(cl:ensure-generic-function 'goal_pos-val :lambda-list '(m))
(cl:defmethod goal_pos-val ((m <goal-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cam-srv:goal_pos-val is deprecated.  Use cam-srv:goal_pos instead.")
  (goal_pos m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goal-response>) ostream)
  "Serializes a message object of type '<goal-response>"
  (cl:let* ((signed (cl:slot-value msg 'goal_pos)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goal-response>) istream)
  "Deserializes a message object of type '<goal-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'goal_pos) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goal-response>)))
  "Returns string type for a service object of type '<goal-response>"
  "cam/goalResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goal-response)))
  "Returns string type for a service object of type 'goal-response"
  "cam/goalResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goal-response>)))
  "Returns md5sum for a message object of type '<goal-response>"
  "2ceead7433605f9dde8aff8b1e4a54fc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goal-response)))
  "Returns md5sum for a message object of type 'goal-response"
  "2ceead7433605f9dde8aff8b1e4a54fc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goal-response>)))
  "Returns full string definition for message of type '<goal-response>"
  (cl:format cl:nil "int32 goal_pos~%~%~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goal-response)))
  "Returns full string definition for message of type 'goal-response"
  (cl:format cl:nil "int32 goal_pos~%~%~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goal-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goal-response>))
  "Converts a ROS message object to a list"
  (cl:list 'goal-response
    (cl:cons ':goal_pos (goal_pos msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'goal)))
  'goal-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'goal)))
  'goal-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goal)))
  "Returns string type for a service object of type '<goal>"
  "cam/goal")