#include <iostream>
#include <Eigen/Dense>

int main() {

    Eigen::Matrix<int, 3, 3> square;
    square << 1, 2, 3,
              4, 5, 6,
              7, 8, 9;

    // Upper triangular part of a matrix
    Eigen::MatrixXi upp_tri = square.triangularView<Eigen::Upper>();
    std::cout << upp_tri << std::endl;

    // Lower triangular part of a matrix
    Eigen::MatrixXi low_tri = square.triangularView<Eigen::Lower>();
    std::cout << low_tri << std::endl;

//    std::cout << square.triangularView<Eigen::Lower>() << std::endl;  todo: Why this does not work?

    return 0;
}
