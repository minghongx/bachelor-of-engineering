#include "std_lib_facilities.h"

int main() {
    int x;  // x gets a “random” initial value
    char c;  // c gets a “random” initial value
    double d;  // d gets a “random” initial value
    // – not every bit pattern is a valid floating-point value
    double dd = d;  // potential error: some implementations
    // can’t copy invalid floating-point values
    cout << " x: " << x << " c: " << c << " d: " << d << '\n';
}
