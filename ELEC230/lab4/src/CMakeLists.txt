cmake_minimum_required(VERSION 3.16)
project(lab4)

set(CMAKE_CXX_STANDARD 17)

file(GLOB files *.cpp)
foreach(file ${files})
    string(REGEX REPLACE ".+/(.+)\\..*" "\\1" exe ${file})
    message("    -- src/${exe}.cpp will be compiled to bin/${exe}")
    add_executable(${exe} ${file})
endforeach()

#set(CMAKE_FIND_DEBUG_MODE ON)

find_package(Eigen3 3.3 REQUIRED NO_MODULE)
#[[ ref:
https://blog.csdn.net/renhaofan/article/details/80960694
https://github.com/libigl/eigen/blob/master/INSTALL
https://zhuanlan.zhihu.com/p/361969822
https://eigen.tuxfamily.org/dox/GettingStarted.html
https://eigen.tuxfamily.org/dox/TopicCMakeGuide.html
https://forum.kde.org/viewtopic.php?t=94166
https://stackoverflow.com/questions/23284473/fatal-error-eigen-dense-no-such-file-or-directory
https://stackoverflow.com/questions/62364387/clion-is-unable-to-find-eigen3-on-macos
]]

find_package(Curses REQUIRED)  # https://cmake.org/cmake/help/latest/module/FindCurses.html

target_include_directories(2d_array ${EIGEN3_INCLUDE_DIRS})
target_link_libraries(2d_array Eigen3::Eigen)

target_include_directories(triangular_matrix ${EIGEN3_INCLUDE_DIRS})
target_link_libraries(triangular_matrix Eigen3::Eigen)

target_include_directories(play_ncurses ${CURSES_INCLUDE_DIRS})
target_link_libraries(play_ncurses ${CURSES_LIBRARIES})

#[[ ref:
https://cmake.org/cmake/help/latest/manual/cmake-developer.7.html#standard-variable-names
https://stackoverflow.com/questions/31969547/what-is-the-difference-between-include-directories-and-target-include-directorie
https://stackoverflow.com/questions/40227333/cmake-setup-multiple-projects-and-dependiencies-between-them/40242257#40242257
]]
