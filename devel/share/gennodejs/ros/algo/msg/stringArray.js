// Auto-generated. Do not edit!

// (in-package algo.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class stringArray {
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
    // Serializes a message object of type stringArray
    // Serialize message field [time_stamp]
    bufferOffset = _serializer.float64(obj.time_stamp, buffer, bufferOffset);
    // Serialize message field [data]
    bufferOffset = _arraySerializer.string(obj.data, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type stringArray
    let len;
    let data = new stringArray(null);
    // Deserialize message field [time_stamp]
    data.time_stamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [data]
    data.data = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.data.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'algo/stringArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '93db99df41c7f7b2322d7c908b9a2274';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 time_stamp
    string[] data
    
    
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new stringArray(null);
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

module.exports = stringArray;
