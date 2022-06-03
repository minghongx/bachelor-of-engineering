#include "std_lib_facilities.h"

int main() {
    const double cm_per_inch = 2.54;
    int val;
    char unit;
    while (cin >> val >> unit) {  // keep reading
        if (unit == 'i')  // 'i' for inch
            cout << val << "in == " << val*cm_per_inch << "cm" << endl;
        else if (unit == 'c')  // 'c' for cm
            cout << val << "cm == " << val/cm_per_inch << "in" << endl;
        else
            return 0;  // terminate on a “bad unit”, e.g. 'q'
    }
}
