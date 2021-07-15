// Auto-generated. Do not edit!

// (in-package beacon_cam.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class point_transformRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.cp_pos = null;
    }
    else {
      if (initObj.hasOwnProperty('cp_pos')) {
        this.cp_pos = initObj.cp_pos
      }
      else {
        this.cp_pos = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type point_transformRequest
    // Serialize message field [cp_pos]
    bufferOffset = _arraySerializer.float32(obj.cp_pos, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type point_transformRequest
    let len;
    let data = new point_transformRequest(null);
    // Deserialize message field [cp_pos]
    data.cp_pos = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.cp_pos.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'beacon_cam/point_transformRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2c59ccc2cc2cec956d695cd364b937b9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32[] cp_pos
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new point_transformRequest(null);
    if (msg.cp_pos !== undefined) {
      resolved.cp_pos = msg.cp_pos;
    }
    else {
      resolved.cp_pos = []
    }

    return resolved;
    }
};

class point_transformResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.tf_pos = null;
    }
    else {
      if (initObj.hasOwnProperty('tf_pos')) {
        this.tf_pos = initObj.tf_pos
      }
      else {
        this.tf_pos = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type point_transformResponse
    // Serialize message field [tf_pos]
    bufferOffset = _arraySerializer.float32(obj.tf_pos, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type point_transformResponse
    let len;
    let data = new point_transformResponse(null);
    // Deserialize message field [tf_pos]
    data.tf_pos = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.tf_pos.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'beacon_cam/point_transformResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ae905da94d0aa87c4e9cf6404d56be17';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32[] tf_pos
    
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new point_transformResponse(null);
    if (msg.tf_pos !== undefined) {
      resolved.tf_pos = msg.tf_pos;
    }
    else {
      resolved.tf_pos = []
    }

    return resolved;
    }
};

module.exports = {
  Request: point_transformRequest,
  Response: point_transformResponse,
  md5sum() { return '7e85000443f684022e3afc6d15f3d299'; },
  datatype() { return 'beacon_cam/point_transform'; }
};
