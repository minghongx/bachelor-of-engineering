class Circle {
private:
    double radius;
public:
    Circle(double r) {
        radius = r;
    }
    double circum() {
        return 2 * radius * 3.14159265;
    }
};


#include <iostream>
int main() {

    Circle foo(10.0);
    Circle bar = 20.0;
    Circle baz {30.0};
    Circle qux = {40.0};

    std::cout << "foo's circumference: " << foo.circum() << std::endl;

    return 0;
}
