class Date {
private:
    int y, m, d;
public:
    Date(int y, int m, int d);
    void add_day(int n);
    int month() {
        return m;
    }
    int day() {
        return d;
    }
    int year() {
        return y;
    }
};

#include <iostream>
int main() {
    Date my_birthday {1950, 12, 30};
    std::cout << my_birthday.month() << std::endl;
    my_birthday.m = 14;
}
