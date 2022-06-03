#include <iostream>
//#include <format>  // fixme: Up to 15 Oct 2021, Clang libc++ does not fully support the C++20 text formatting feature according to en.cppreference.com/w/cpp/compiler_support
#include <iomanip>

int square(int x);

int main() {
    for (int positive_int = 1; positive_int < 100; ++positive_int) {
//        std::cout << std::format("{:>3} squared equals {:<5}", positive_int, square(positive_int)) << std::endl;
        std::cout << std::right << std::setw(3) << positive_int << " squared equals " << std::left << std::setw(5) << square(positive_int) << std::endl;
    }

    return 0;
}

int square(int x) {
    return x * x;
}
