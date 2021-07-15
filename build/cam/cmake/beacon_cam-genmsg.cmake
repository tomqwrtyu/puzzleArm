# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "beacon_cam: 0 messages, 1 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(beacon_cam_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/neil/catkin_ws/src/cam/srv/num_state.srv" NAME_WE)
add_custom_target(_beacon_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "beacon_cam" "/home/neil/catkin_ws/src/cam/srv/num_state.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(beacon_cam
  "/home/neil/catkin_ws/src/cam/srv/num_state.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/beacon_cam
)

### Generating Module File
_generate_module_cpp(beacon_cam
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/beacon_cam
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(beacon_cam_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(beacon_cam_generate_messages beacon_cam_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/neil/catkin_ws/src/cam/srv/num_state.srv" NAME_WE)
add_dependencies(beacon_cam_generate_messages_cpp _beacon_cam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(beacon_cam_gencpp)
add_dependencies(beacon_cam_gencpp beacon_cam_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS beacon_cam_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(beacon_cam
  "/home/neil/catkin_ws/src/cam/srv/num_state.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/beacon_cam
)

### Generating Module File
_generate_module_eus(beacon_cam
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/beacon_cam
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(beacon_cam_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(beacon_cam_generate_messages beacon_cam_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/neil/catkin_ws/src/cam/srv/num_state.srv" NAME_WE)
add_dependencies(beacon_cam_generate_messages_eus _beacon_cam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(beacon_cam_geneus)
add_dependencies(beacon_cam_geneus beacon_cam_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS beacon_cam_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(beacon_cam
  "/home/neil/catkin_ws/src/cam/srv/num_state.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/beacon_cam
)

### Generating Module File
_generate_module_lisp(beacon_cam
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/beacon_cam
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(beacon_cam_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(beacon_cam_generate_messages beacon_cam_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/neil/catkin_ws/src/cam/srv/num_state.srv" NAME_WE)
add_dependencies(beacon_cam_generate_messages_lisp _beacon_cam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(beacon_cam_genlisp)
add_dependencies(beacon_cam_genlisp beacon_cam_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS beacon_cam_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(beacon_cam
  "/home/neil/catkin_ws/src/cam/srv/num_state.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/beacon_cam
)

### Generating Module File
_generate_module_nodejs(beacon_cam
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/beacon_cam
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(beacon_cam_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(beacon_cam_generate_messages beacon_cam_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/neil/catkin_ws/src/cam/srv/num_state.srv" NAME_WE)
add_dependencies(beacon_cam_generate_messages_nodejs _beacon_cam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(beacon_cam_gennodejs)
add_dependencies(beacon_cam_gennodejs beacon_cam_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS beacon_cam_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(beacon_cam
  "/home/neil/catkin_ws/src/cam/srv/num_state.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/beacon_cam
)

### Generating Module File
_generate_module_py(beacon_cam
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/beacon_cam
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(beacon_cam_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(beacon_cam_generate_messages beacon_cam_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/neil/catkin_ws/src/cam/srv/num_state.srv" NAME_WE)
add_dependencies(beacon_cam_generate_messages_py _beacon_cam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(beacon_cam_genpy)
add_dependencies(beacon_cam_genpy beacon_cam_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS beacon_cam_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/beacon_cam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/beacon_cam
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(beacon_cam_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/beacon_cam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/beacon_cam
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(beacon_cam_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/beacon_cam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/beacon_cam
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(beacon_cam_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/beacon_cam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/beacon_cam
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(beacon_cam_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/beacon_cam)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/beacon_cam\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/beacon_cam
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(beacon_cam_generate_messages_py std_msgs_generate_messages_py)
endif()
