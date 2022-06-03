#include <std_lib_facilities.h>
int main() {  // inch to cm conversion
    const double cm_per_inch = 2.54;  // number of centimeters per inch
    int length = 0;  // length in inches
    while (length != 0);  // length == 0 is used to exit the program
    {  // a compound statement (a block)
        cout << "Please enter a length in inches: ";
        cin >> length;
        cout << length << "in. = " << cm_per_inch*length << "cm.\n";
    }
}
