#include "sorting_algorithms.hpp"
#include "read_test_data.hpp"
#include <gtest/gtest.h>

TEST(TestSortingAlgorithms, MergeSort) {
    auto list = read_list_from_the_file();
    sort::merge_sort(list.begin(), list.end());
    EXPECT_EQ(std::is_sorted(list.begin(), list.end()), true);
}

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
