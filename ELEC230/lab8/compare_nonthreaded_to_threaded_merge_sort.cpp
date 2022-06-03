#include "sorting_algorithms.hpp"
#include "tests/read_test_data.hpp"
#include <thread>
#include <iostream>
#include <chrono>

int main() {
// nonthreaded mergesort
    auto list = read_list_from_the_file();

    auto start = std::chrono::high_resolution_clock::now();
    sort::merge_sort(list.begin(), list.end());
    auto stop = std::chrono::high_resolution_clock::now();
    auto duration = duration_cast<std::chrono::microseconds>(stop - start);
    std::cout << duration.count() << " microseconds" << std::endl;

// threaded mergesort
    list = read_list_from_the_file();
    auto first = list.begin();
    auto last = list.end();
    auto middle = first + std::distance(first, last)/2;

    start = std::chrono::high_resolution_clock::now();
    std::thread t1(sort::merge_sort<decltype(first)>, first, middle);
    std::thread t2(sort::merge_sort<decltype(middle)>, middle, last);
    t1.join();
    t2.join();
    std::inplace_merge(first, middle, last);
    stop = std::chrono::high_resolution_clock::now();
    duration = duration_cast<std::chrono::microseconds>(stop - start);
    std::cout << duration.count() << " microseconds" <<std::endl;
}