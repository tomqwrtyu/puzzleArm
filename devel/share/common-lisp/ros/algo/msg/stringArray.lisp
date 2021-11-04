; Auto-generated. Do not edit!


(cl:in-package algo-msg)


;//! \htmlinclude stringArray.msg.html

(cl:defclass <stringArray> (roslisp-msg-protocol:ros-message)
  ((time_stamp
    :reader time_stamp
    :initarg :time_stamp
    :type cl:float
    :initform 0.0)
   (data
    :reader data
    :initarg :data
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass stringArray (<stringArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <stringArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'stringArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name algo-msg:<stringArray> is deprecated: use algo-msg:stringArray instead.")))

(cl:ensure-generic-function 'time_stamp-val :lambda-list '(m))
(cl:defmethod time_stamp-val ((m <stringArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader algo-msg:time_stamp-val is deprecated.  Use algo-msg:time_stamp instead.")
  (time_stamp m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <stringArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader algo-msg:data-val is deprecated.  Use algo-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <stringArray>) ostream)
  "Serializes a message object of type '<stringArray>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'time_stamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <stringArray>) istream)
  "Deserializes a message object of type '<stringArray>"
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
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<stringArray>)))
  "Returns string type for a message object of type '<stringArray>"
  "algo/stringArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'stringArray)))
  "Returns string type for a message object of type 'stringArray"
  "algo/stringArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<stringArray>)))
  "Returns md5sum for a message object of type '<stringArray>"
  "93db99df41c7f7b2322d7c908b9a2274")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'stringArray)))
  "Returns md5sum for a message object of type 'stringArray"
  "93db99df41c7f7b2322d7c908b9a2274")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<stringArray>)))
  "Returns full string definition for message of type '<stringArray>"
  (cl:format cl:nil "float64 time_stamp~%string[] data~%~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'stringArray)))
  "Returns full string definition for message of type 'stringArray"
  (cl:format cl:nil "float64 time_stamp~%string[] data~%~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <stringArray>))
  (cl:+ 0
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <stringArray>))
  "Converts a ROS message object to a list"
  (cl:list 'stringArray
    (cl:cons ':time_stamp (time_stamp msg))
    (cl:cons ':data (data msg))
))
