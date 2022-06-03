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

    Rectangle rect;
    rect.set_value(3, 4);
    std::cout << "area: " << rect.area();

    return 0;
}
