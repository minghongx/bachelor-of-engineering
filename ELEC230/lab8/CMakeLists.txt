cmake_minimum_required(VERSION 3.16)
project(lab8)

set(CMAKE_CXX_STANDARD 20)

#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR})

#set(CMAKE_FIND_DEBUG_MODE ON)

enable_testing()
include(GoogleTest)
add_subdirectory(tests)

add_executable(compare_nonthreaded_to_threaded_merge_sort compare_nonthreaded_to_threaded_merge_sort.cpp)