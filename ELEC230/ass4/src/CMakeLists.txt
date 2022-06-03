cmake_minimum_required(VERSION 3.18)
project(ass4)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(OpenCV 4.2.0 EXACT REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})

file(GLOB files ${CMAKE_CURRENT_SOURCE_DIR}/*.cxx)
foreach(file ${files})
    string(REGEX REPLACE ".+/(.+)\\..*" "\\1" bin ${file})
    add_executable(${bin} ${file})
    target_link_libraries(${bin} ${OpenCV_LIBS})
endforeach()
