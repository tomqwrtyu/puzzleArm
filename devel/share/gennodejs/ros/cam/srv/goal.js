// Auto-generated. Do not edit!

// (in-package cam.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class goalRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.req = null;
    }
    else {
      if (initObj.hasOwnProperty('req')) {
        this.req = initObj.req
      }
      else {
        this.req = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type goalRequest
    // Serialize message field [req]
    bufferOffset = _serializer.bool(obj.req, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type goalRequest
    let len;
    let data = new goalRequest(null);
    // Deserialize message field [req]
    data.req = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'cam/goalRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'be3c44e19d0c6b00b25e356c69155e2a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool req
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new goalRequest(null);
    if (msg.req !== undefined) {
      resolved.req = msg.req;
    }
    else {
      resolved.req = false
    }

    return resolved;
    }
};

class goalResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.goal_pos = null;
    }
    else {
      if (initObj.hasOwnProperty('goal_pos')) {
        this.goal_pos = initObj.goal_pos
      }
      else {
        this.goal_pos = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type goalResponse
    // Serialize message field [goal_pos]
    bufferOffset = _serializer.int32(obj.goal_pos, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type goalResponse
    let len;
    let data = new goalResponse(null);
    // Deserialize message field [goal_pos]
    data.goal_pos = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'cam/goalResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b04d99b7751e9a21f2eb13dc038d6790';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 goal_pos
    
    
    
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new goalResponse(null);
    if (msg.goal_pos !== undefined) {
      resolved.goal_pos = msg.goal_pos;
    }
    else {
      resolved.goal_pos = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: goalRequest,
  Response: goalResponse,
  md5sum() { return '2ceead7433605f9dde8aff8b1e4a54fc'; },
  datatype() { return 'cam/goal'; }
};
