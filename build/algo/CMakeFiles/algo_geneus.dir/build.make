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

# Utility rule file for algo_geneus.

# Include the progress variables for this target.
include algo/CMakeFiles/algo_geneus.dir/progress.make

algo_geneus: algo/CMakeFiles/algo_geneus.dir/build.make

.PHONY : algo_geneus

# Rule to build all files generated by this target.
algo/CMakeFiles/algo_geneus.dir/build: algo_geneus

.PHONY : algo/CMakeFiles/algo_geneus.dir/build

algo/CMakeFiles/algo_geneus.dir/clean:
	cd /home/nvidia/puzzleArm/build/algo && $(CMAKE_COMMAND) -P CMakeFiles/algo_geneus.dir/cmake_clean.cmake
.PHONY : algo/CMakeFiles/algo_geneus.dir/clean

algo/CMakeFiles/algo_geneus.dir/depend:
	cd /home/nvidia/puzzleArm/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/nvidia/puzzleArm/src /home/nvidia/puzzleArm/src/algo /home/nvidia/puzzleArm/build /home/nvidia/puzzleArm/build/algo /home/nvidia/puzzleArm/build/algo/CMakeFiles/algo_geneus.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : algo/CMakeFiles/algo_geneus.dir/depend

