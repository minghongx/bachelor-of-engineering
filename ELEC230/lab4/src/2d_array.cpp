#include <iostream>
#include <Eigen/Dense>
// ref: https://stackoverflow.com/questions/2076624/c-matrix-class

using Eigen::MatrixBase;
using Eigen::Matrix;

/* Eigen3 Generic Programming Refs
 * https://eigen.tuxfamily.org/dox/TopicFunctionTakingEigenTypes.html
 * https://eigen.tuxfamily.org/dox/classEigen_1_1MatrixBase.html
 * https://eigen.tuxfamily.org/dox/classEigen_1_1DenseBase.html#a5feed465b3a8e60c47e73ecce83e39a2
 */
template <typename Derived>
inline typename Derived::Scalar
left_diagonal_sum (MatrixBase<Derived> const& square_matrix) {
    if (square_matrix.rows() != square_matrix.cols()) throw std::invalid_argument("matrix must be square.");
    return square_matrix.trace();
}

template <typename Derived>
inline typename Derived::Scalar
right_diagonal_sum (MatrixBase<Derived> const& square_matrix) {
    if (square_matrix.rows() != square_matrix.cols()) throw std::invalid_argument("matrix must be square.");
    return square_matrix.rowwise().reverse().trace();
    // ref: https://stackoverflow.com/questions/19647270/how-can-i-mirror-a-matrix-about-one-of-its-dimensions
}
/* typename, template arg deduction, const T& vs T const&, and inline
 * https://zh.wikipedia.org/wiki/Typename
 * https://en.cppreference.com/w/cpp/language/template_argument_deduction
 * https://stackoverflow.com/questions/2640446/why-do-some-people-prefer-t-const-over-const-t
 * https://www.runoob.com/cplusplus/cpp-inline-functions.html
 */

int main() {  // todo: include an unit test framework, then

//unit test

    // not square
    Matrix<int, 2, 3> not_square;
    not_square << 1, 0, 4,
                  7, 3, 0;
// todo: using assert to check an expected exception is thrown
//    std::cout << left_diagonal_sum(not_square) << std::endl;
//    std::cout << right_diagonal_sum(not_square) << std::endl;

// todo: using assert to check the return and the return type
    // int
    Matrix<int, 3, 3> int_square;
    int_square << 1, 0, 4,
                  0, 2, 0,
                  4, 0, 1;
    std::cout << left_diagonal_sum(int_square) << std::endl;
    std::cout << right_diagonal_sum(int_square) << std::endl;

    // float
    Matrix<float, 3, 3> float_square;
    float_square << 1.1f, 0.0f, 4.6f,
                    0.0f, 2.8f, 0.0f,
                    4.6f, 0.0f, 1.1f;
    std::cout << left_diagonal_sum(float_square) << std::endl;
    std::cout << right_diagonal_sum(float_square) << std::endl;

    // double
    Matrix<double, 3, 3> double_square;
    float_square << 1.1f, 0.0f, 4.6f,
                    0.0f, 2.8f, 0.0f,
                    4.6f, 0.0f, 1.1f;
    std::cout << left_diagonal_sum(float_square) << std::endl;
    std::cout << right_diagonal_sum(float_square) << std::endl;

//unit test end

    return 0;
}


/**
 * ref:
 * http://eigen.tuxfamily.org/dox/group__QuickRefPage.html
 * https://blog.csdn.net/u012424737/article/details/106342825
 * https://igl.ethz.ch/projects/libigl/matlab-to-eigen.html
 */