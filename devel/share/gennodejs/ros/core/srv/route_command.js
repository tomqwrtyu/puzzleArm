// Auto-generated. Do not edit!

// (in-package core.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class route_commandRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.route = null;
    }
    else {
      if (initObj.hasOwnProperty('route')) {
        this.route = initObj.route
      }
      else {
        this.route = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type route_commandRequest
    // Serialize message field [route]
    bufferOffset = _arraySerializer.int32(obj.route, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type route_commandRequest
    let len;
    let data = new route_commandRequest(null);
    // Deserialize message field [route]
    data.route = _arrayDeserializer.int32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.route.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'core/route_commandRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ba095d58d975bd3c99ae6d685178a1bb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32[] route
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new route_commandRequest(null);
    if (msg.route !== undefined) {
      resolved.route = msg.route;
    }
    else {
      resolved.route = []
    }

    return resolved;
    }
};

class route_commandResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.stm_state = null;
    }
    else {
      if (initObj.hasOwnProperty('stm_state')) {
        this.stm_state = initObj.stm_state
      }
      else {
        this.stm_state = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type route_commandResponse
    // Serialize message field [stm_state]
    bufferOffset = _serializer.uint8(obj.stm_state, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type route_commandResponse
    let len;
    let data = new route_commandResponse(null);
    // Deserialize message field [stm_state]
    data.stm_state = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'core/route_commandResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '34ab34fb3d339f1c0bb6b256e514d01b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 stm_state
    
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new route_commandResponse(null);
    if (msg.stm_state !== undefined) {
      resolved.stm_state = msg.stm_state;
    }
    else {
      resolved.stm_state = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: route_commandRequest,
  Response: route_commandResponse,
  md5sum() { return 'e934608428f4a678bcc6b43ef7249b80'; },
  datatype() { return 'core/route_command'; }
};
