cmake_minimum_required(VERSION 3.16)
project(ass2)

set(CMAKE_CXX_STANDARD 17)

add_subdirectory(VL53L1X)
add_subdirectory(AK09918-ICM20600)

add_executable(Range Range.cpp)
target_link_libraries(Range PUBLIC VL53L1X)

add_executable(TEST_ICM20600 test_icm20600.c)
target_link_libraries(TEST_ICM20600 PUBLIC AK09918-ICM20600)

add_executable(TEST_AK09918 test_ak09918.c)
target_link_libraries(TEST_AK09918 PUBLIC AK09918-ICM20600)