; Auto-generated. Do not edit!


(cl:in-package algo-srv)


;//! \htmlinclude num_state-request.msg.html

(cl:defclass <num_state-request> (roslisp-msg-protocol:ros-message)
  ((num_state
    :reader num_state
    :initarg :num_state
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass num_state-request (<num_state-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <num_state-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'num_state-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name algo-srv:<num_state-request> is deprecated: use algo-srv:num_state-request instead.")))

(cl:ensure-generic-function 'num_state-val :lambda-list '(m))
(cl:defmethod num_state-val ((m <num_state-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader algo-srv:num_state-val is deprecated.  Use algo-srv:num_state instead.")
  (num_state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <num_state-request>) ostream)
  "Serializes a message object of type '<num_state-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'num_state))))
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
   (cl:slot-value msg 'num_state))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <num_state-request>) istream)
  "Deserializes a message object of type '<num_state-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'num_state) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'num_state)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<num_state-request>)))
  "Returns string type for a service object of type '<num_state-request>"
  "algo/num_stateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'num_state-request)))
  "Returns string type for a service object of type 'num_state-request"
  "algo/num_stateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<num_state-request>)))
  "Returns md5sum for a message object of type '<num_state-request>"
  "3ef8d46e3fcd35484b18eba316522655")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'num_state-request)))
  "Returns md5sum for a message object of type 'num_state-request"
  "3ef8d46e3fcd35484b18eba316522655")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<num_state-request>)))
  "Returns full string definition for message of type '<num_state-request>"
  (cl:format cl:nil "int32[] num_state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'num_state-request)))
  "Returns full string definition for message of type 'num_state-request"
  (cl:format cl:nil "int32[] num_state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <num_state-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'num_state) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <num_state-request>))
  "Converts a ROS message object to a list"
  (cl:list 'num_state-request
    (cl:cons ':num_state (num_state msg))
))
;//! \htmlinclude num_state-response.msg.html

(cl:defclass <num_state-response> (roslisp-msg-protocol:ros-message)
  ((req
    :reader req
    :initarg :req
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass num_state-response (<num_state-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <num_state-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'num_state-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name algo-srv:<num_state-response> is deprecated: use algo-srv:num_state-response instead.")))

(cl:ensure-generic-function 'req-val :lambda-list '(m))
(cl:defmethod req-val ((m <num_state-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader algo-srv:req-val is deprecated.  Use algo-srv:req instead.")
  (req m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <num_state-response>) ostream)
  "Serializes a message object of type '<num_state-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'req) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <num_state-response>) istream)
  "Deserializes a message object of type '<num_state-response>"
    (cl:setf (cl:slot-value msg 'req) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<num_state-response>)))
  "Returns string type for a service object of type '<num_state-response>"
  "algo/num_stateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'num_state-response)))
  "Returns string type for a service object of type 'num_state-response"
  "algo/num_stateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<num_state-response>)))
  "Returns md5sum for a message object of type '<num_state-response>"
  "3ef8d46e3fcd35484b18eba316522655")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'num_state-response)))
  "Returns md5sum for a message object of type 'num_state-response"
  "3ef8d46e3fcd35484b18eba316522655")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<num_state-response>)))
  "Returns full string definition for message of type '<num_state-response>"
  (cl:format cl:nil "bool req~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'num_state-response)))
  "Returns full string definition for message of type 'num_state-response"
  (cl:format cl:nil "bool req~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <num_state-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <num_state-response>))
  "Converts a ROS message object to a list"
  (cl:list 'num_state-response
    (cl:cons ':req (req msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'num_state)))
  'num_state-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'num_state)))
  'num_state-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'num_state)))
  "Returns string type for a service object of type '<num_state>"
  "algo/num_state")