// do a bit of very simple arithmetic:
#include “std_lib_facilities.h”
int main()
{
    cout << "please enter a floating-point number: ";  // prompt for a number
    double n;  // floating-point variable
    cin >> n;
    cout << "n == " << n
        << "\nn+1 == " << n+1  // '\n' means “a newline”
        << "\nthree times n == " << 3*n
        << "\ntwice n == " << n+n
        << "\nn squared == " << n*n
        << "half of n == " << n/2
        << "\nsquare root of n == " << squrt(n)  // library function
        << '\n’;
}
