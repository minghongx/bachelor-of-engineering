#include "std_lib_facilities.h"

int main() {
    cout << "please enter your first and second names" << endl;
    string first;
    string second;
    cin >> first >> second;  // read two strings
    string name = first + ' ' + second;  // concatenate strings, separated by a space
    cout << "Hello, "<< name << endl;
}
