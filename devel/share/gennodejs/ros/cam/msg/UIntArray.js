// Auto-generated. Do not edit!

// (in-package cam.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class UIntArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.time_stamp = null;
      this.data = null;
    }
    else {
      if (initObj.hasOwnProperty('time_stamp')) {
        this.time_stamp = initObj.time_stamp
      }
      else {
        this.time_stamp = 0.0;
      }
      if (initObj.hasOwnProperty('data')) {
        this.data = initObj.data
      }
      else {
        this.data = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UIntArray
    // Serialize message field [time_stamp]
    bufferOffset = _serializer.float64(obj.time_stamp, buffer, bufferOffset);
    // Serialize message field [data]
    bufferOffset = _arraySerializer.uint64(obj.data, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UIntArray
    let len;
    let data = new UIntArray(null);
    // Deserialize message field [time_stamp]
    data.time_stamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [data]
    data.data = _arrayDeserializer.uint64(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.data.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'cam/UIntArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd2631c5713f06405dcb0ef2b331886d9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 time_stamp
    uint64[] data
    
    
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new UIntArray(null);
    if (msg.time_stamp !== undefined) {
      resolved.time_stamp = msg.time_stamp;
    }
    else {
      resolved.time_stamp = 0.0
    }

    if (msg.data !== undefined) {
      resolved.data = msg.data;
    }
    else {
      resolved.data = []
    }

    return resolved;
    }
};

module.exports = UIntArray;
