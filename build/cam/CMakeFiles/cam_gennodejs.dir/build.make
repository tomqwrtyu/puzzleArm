# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/nvidia/puzzleArm/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/nvidia/puzzleArm/build

# Utility rule file for cam_gennodejs.

# Include the progress variables for this target.
include cam/CMakeFiles/cam_gennodejs.dir/progress.make

cam_gennodejs: cam/CMakeFiles/cam_gennodejs.dir/build.make

.PHONY : cam_gennodejs

# Rule to build all files generated by this target.
cam/CMakeFiles/cam_gennodejs.dir/build: cam_gennodejs

.PHONY : cam/CMakeFiles/cam_gennodejs.dir/build

cam/CMakeFiles/cam_gennodejs.dir/clean:
	cd /home/nvidia/puzzleArm/build/cam && $(CMAKE_COMMAND) -P CMakeFiles/cam_gennodejs.dir/cmake_clean.cmake
.PHONY : cam/CMakeFiles/cam_gennodejs.dir/clean

cam/CMakeFiles/cam_gennodejs.dir/depend:
	cd /home/nvidia/puzzleArm/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/nvidia/puzzleArm/src /home/nvidia/puzzleArm/src/cam /home/nvidia/puzzleArm/build /home/nvidia/puzzleArm/build/cam /home/nvidia/puzzleArm/build/cam/CMakeFiles/cam_gennodejs.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : cam/CMakeFiles/cam_gennodejs.dir/depend

