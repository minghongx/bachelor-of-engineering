class Rectangle {
private:
    int width, height;
public:
    Rectangle (int, int);

    int area() {
        return width*height;
    }
};

Rectangle::Rectangle(int a, int b) {
    width = a;
    height = b;
}

#include <iostream>
int main() {

    Rectangle rect(3, 4);
    Rectangle rectb(5, 6);
    std::cout << "rect area: " << rect.area() << std::endl;
    std::cout << "rectb area: " << rectb.area() << std::endl;

    return 0;
}