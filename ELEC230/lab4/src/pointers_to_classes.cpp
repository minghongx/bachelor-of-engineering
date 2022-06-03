class Rectangle {
private:
    int width, height;
public:
    Rectangle(int x, int y) : width(x), height(y) {}
    int area(void) {
        return width * height;
    }
};


#include <iostream>
int main() {
    Rectangle obj(3, 4);
    Rectangle* foo;
    Rectangle* bar;
    Rectangle* baz;

    foo = &obj;
    bar = new Rectangle(5, 6);
    baz = new Rectangle[2] {{2,5}, {3,6}};

    std::cout << "obj's area: " << obj.area() << std::endl;
    std::cout << "*foo's area: " << foo->area() << std::endl;
    std::cout << "*bar's area: " << bar->area() << std::endl;
    std::cout << "baz[0]'s area: " << baz[0].area() << std::endl;
    std::cout << "baz[1]'s area: " << baz[1].area() << std::endl;

    delete bar;
    delete[] baz;

    return 0;
}