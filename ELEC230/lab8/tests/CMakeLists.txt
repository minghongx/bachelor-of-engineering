add_subdirectory("${PROJECT_SOURCE_DIR}/external/googletest" "${PROJECT_BINARY_DIR}/external/googletest")
include_directories(${PROJECT_SOURCE_DIR})  # in order to find files outside of tests/ but under the project root.

macro(add_googletest TEST_NAME)
    add_executable(${TEST_NAME} ${ARGN})
    target_link_libraries(${TEST_NAME} gtest gmock gtest_main)
    gtest_discover_tests(${TEST_NAME}
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    )
endmacro()

add_googletest(test_merge_sort test_merge_sort.cpp)
