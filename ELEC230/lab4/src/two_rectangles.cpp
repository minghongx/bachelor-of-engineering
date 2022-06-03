class Rectangle {
private:
    int width, height;
public:
    void set_value (int, int);
    int area() {return width*height}
};

void Rectangle::set_value(int, int) {
    width = x;
    height = y;
}


#include <iostream>
int main() {

    Rectangle rect rectb;
    rect.set_value(3, 4);
    rectb.set_value(5, 6);
    std::cout << "rect area: " << rect.area() << std::endl;
    std::cout << "rectb area: " << rectb.area() << std::endl;

    return 0;
}
