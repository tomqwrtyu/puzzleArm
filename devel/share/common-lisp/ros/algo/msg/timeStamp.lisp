; Auto-generated. Do not edit!


(cl:in-package algo-msg)


;//! \htmlinclude timeStamp.msg.html

(cl:defclass <timeStamp> (roslisp-msg-protocol:ros-message)
  ((time_stamp
    :reader time_stamp
    :initarg :time_stamp
    :type cl:float
    :initform 0.0))
)

(cl:defclass timeStamp (<timeStamp>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <timeStamp>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'timeStamp)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name algo-msg:<timeStamp> is deprecated: use algo-msg:timeStamp instead.")))

(cl:ensure-generic-function 'time_stamp-val :lambda-list '(m))
(cl:defmethod time_stamp-val ((m <timeStamp>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader algo-msg:time_stamp-val is deprecated.  Use algo-msg:time_stamp instead.")
  (time_stamp m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <timeStamp>) ostream)
  "Serializes a message object of type '<timeStamp>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'time_stamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <timeStamp>) istream)
  "Deserializes a message object of type '<timeStamp>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'time_stamp) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<timeStamp>)))
  "Returns string type for a message object of type '<timeStamp>"
  "algo/timeStamp")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'timeStamp)))
  "Returns string type for a message object of type 'timeStamp"
  "algo/timeStamp")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<timeStamp>)))
  "Returns md5sum for a message object of type '<timeStamp>"
  "1b5e4ee2dd9c99a9b543c72da6261542")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'timeStamp)))
  "Returns md5sum for a message object of type 'timeStamp"
  "1b5e4ee2dd9c99a9b543c72da6261542")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<timeStamp>)))
  "Returns full string definition for message of type '<timeStamp>"
  (cl:format cl:nil "float64 time_stamp~%~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'timeStamp)))
  "Returns full string definition for message of type 'timeStamp"
  (cl:format cl:nil "float64 time_stamp~%~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <timeStamp>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <timeStamp>))
  "Converts a ROS message object to a list"
  (cl:list 'timeStamp
    (cl:cons ':time_stamp (time_stamp msg))
))
