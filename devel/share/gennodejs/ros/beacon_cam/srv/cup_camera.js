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

class cup_cameraRequest {
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
    // Serializes a message object of type cup_cameraRequest
    // Serialize message field [req]
    bufferOffset = _serializer.bool(obj.req, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type cup_cameraRequest
    let len;
    let data = new cup_cameraRequest(null);
    // Deserialize message field [req]
    data.req = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'beacon_cam/cup_cameraRequest';
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
    const resolved = new cup_cameraRequest(null);
    if (msg.req !== undefined) {
      resolved.req = msg.req;
    }
    else {
      resolved.req = false
    }

    return resolved;
    }
};

class cup_cameraResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.color = null;
      this.cup_pos = null;
    }
    else {
      if (initObj.hasOwnProperty('color')) {
        this.color = initObj.color
      }
      else {
        this.color = [];
      }
      if (initObj.hasOwnProperty('cup_pos')) {
        this.cup_pos = initObj.cup_pos
      }
      else {
        this.cup_pos = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type cup_cameraResponse
    // Serialize message field [color]
    bufferOffset = _arraySerializer.int32(obj.color, buffer, bufferOffset, null);
    // Serialize message field [cup_pos]
    bufferOffset = _arraySerializer.float32(obj.cup_pos, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type cup_cameraResponse
    let len;
    let data = new cup_cameraResponse(null);
    // Deserialize message field [color]
    data.color = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [cup_pos]
    data.cup_pos = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.color.length;
    length += 4 * object.cup_pos.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'beacon_cam/cup_cameraResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7122df95499befbf2cc9e57c6f43f6c9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32[] color
    float32[] cup_pos
    
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new cup_cameraResponse(null);
    if (msg.color !== undefined) {
      resolved.color = msg.color;
    }
    else {
      resolved.color = []
    }

    if (msg.cup_pos !== undefined) {
      resolved.cup_pos = msg.cup_pos;
    }
    else {
      resolved.cup_pos = []
    }

    return resolved;
    }
};

module.exports = {
  Request: cup_cameraRequest,
  Response: cup_cameraResponse,
  md5sum() { return '7a20991e451c1198c7723ab0b4776fd9'; },
  datatype() { return 'beacon_cam/cup_camera'; }
};
