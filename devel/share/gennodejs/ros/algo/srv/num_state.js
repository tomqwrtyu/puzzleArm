// Auto-generated. Do not edit!

// (in-package algo.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class num_stateRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.num_state = null;
    }
    else {
      if (initObj.hasOwnProperty('num_state')) {
        this.num_state = initObj.num_state
      }
      else {
        this.num_state = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type num_stateRequest
    // Serialize message field [num_state]
    bufferOffset = _arraySerializer.int32(obj.num_state, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type num_stateRequest
    let len;
    let data = new num_stateRequest(null);
    // Deserialize message field [num_state]
    data.num_state = _arrayDeserializer.int32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.num_state.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'algo/num_stateRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c16ab6459bae9937022fc76d8c8e3999';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32[] num_state
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new num_stateRequest(null);
    if (msg.num_state !== undefined) {
      resolved.num_state = msg.num_state;
    }
    else {
      resolved.num_state = []
    }

    return resolved;
    }
};

class num_stateResponse {
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
    // Serializes a message object of type num_stateResponse
    // Serialize message field [req]
    bufferOffset = _serializer.bool(obj.req, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type num_stateResponse
    let len;
    let data = new num_stateResponse(null);
    // Deserialize message field [req]
    data.req = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'algo/num_stateResponse';
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
    const resolved = new num_stateResponse(null);
    if (msg.req !== undefined) {
      resolved.req = msg.req;
    }
    else {
      resolved.req = false
    }

    return resolved;
    }
};

module.exports = {
  Request: num_stateRequest,
  Response: num_stateResponse,
  md5sum() { return '3ef8d46e3fcd35484b18eba316522655'; },
  datatype() { return 'algo/num_state'; }
};
