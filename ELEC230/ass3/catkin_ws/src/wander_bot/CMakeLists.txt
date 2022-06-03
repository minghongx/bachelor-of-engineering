cmake_minimum_required(VERSION 3.0.2)

#[[
https://stackoverflow.com/questions/51141905/catkin-seperate-compilers-for-different-packages
https://cmake.org/Bug/view.php?id=14841
https://answers.ros.org/question/56398/run-catkin-make-with-custom-compiler/?answer=156891#post-id-156891
https://answers.ros.org/question/320613/catkin_make-vs-catkin_make_isolated-which-is-preferred/

it doesn't work when you set CMAKE_TOOLCHAIN_FILE after invoking project() because project() is 
what actually kicks off the compiler detection process. So variables like CMAKE_TOOLCHAIN_FILE, 
CMAKE_SYSTEM_NAME, CMAKE_C_COMPILER, etc must be set before project() is called, otherwise CMake 
just uses the defaults for the host system.
From: https://github.com/queezythegreat/arduino-cmake/issues/38#issuecomment-365770806
]]
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/toolchain.cmake)

project(wander_bot)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
)

catkin_package()

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable(ass3 src/ass3.cxx src/TurtleBot3.cxx src/msg_factory.cxx)
target_link_libraries(ass3 ${catkin_LIBRARIES})
