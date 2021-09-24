; Auto-generated. Do not edit!


(cl:in-package cam-msg)


;//! \htmlinclude UInt8Array.msg.html

(cl:defclass <UInt8Array> (roslisp-msg-protocol:ros-message)
  ((time_stamp
    :reader time_stamp
    :initarg :time_stamp
    :type cl:float
    :initform 0.0)
   (data
    :reader data
    :initarg :data
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass UInt8Array (<UInt8Array>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UInt8Array>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UInt8Array)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name cam-msg:<UInt8Array> is deprecated: use cam-msg:UInt8Array instead.")))

(cl:ensure-generic-function 'time_stamp-val :lambda-list '(m))
(cl:defmethod time_stamp-val ((m <UInt8Array>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cam-msg:time_stamp-val is deprecated.  Use cam-msg:time_stamp instead.")
  (time_stamp m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <UInt8Array>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cam-msg:data-val is deprecated.  Use cam-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UInt8Array>) ostream)
  "Serializes a message object of type '<UInt8Array>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'time_stamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UInt8Array>) istream)
  "Deserializes a message object of type '<UInt8Array>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'time_stamp) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UInt8Array>)))
  "Returns string type for a message object of type '<UInt8Array>"
  "cam/UInt8Array")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UInt8Array)))
  "Returns string type for a message object of type 'UInt8Array"
  "cam/UInt8Array")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UInt8Array>)))
  "Returns md5sum for a message object of type '<UInt8Array>"
  "83877a2239ce387d8af9561bf045b66c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UInt8Array)))
  "Returns md5sum for a message object of type 'UInt8Array"
  "83877a2239ce387d8af9561bf045b66c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UInt8Array>)))
  "Returns full string definition for message of type '<UInt8Array>"
  (cl:format cl:nil "float32 time_stamp~%uint8[] data~%~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UInt8Array)))
  "Returns full string definition for message of type 'UInt8Array"
  (cl:format cl:nil "float32 time_stamp~%uint8[] data~%~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UInt8Array>))
  (cl:+ 0
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UInt8Array>))
  "Converts a ROS message object to a list"
  (cl:list 'UInt8Array
    (cl:cons ':time_stamp (time_stamp msg))
    (cl:cons ':data (data msg))
))
