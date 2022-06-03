#include <iostream>

int f(int& a) { a = a + 1; return a; }

int main() {

    int xx = 0;
    std::cout << f(xx) << std::endl;  // f change the value of xx
    std::cout << xx << std::endl;

    int yy = 7;
    std::cout << f(yy) << std::endl;  // f change the value of yy
    std::cout << yy << std::endl;

}
