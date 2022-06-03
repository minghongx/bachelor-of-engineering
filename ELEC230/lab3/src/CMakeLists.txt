cmake_minimum_required(VERSION 3.16)
project(lab3)

set(CMAKE_CXX_STANDARD 17)

# single file execution
# https://zhuanlan.zhihu.com/p/277990960
file(GLOB files *.cpp)
foreach(file ${files})
    string(REGEX REPLACE ".+/(.+)\\..*" "\\1" exe ${file})
    message("    -- src/${exe}.cpp will be compiled to bin/${exe}")
    add_executable(${exe} ${file})
endforeach()
