// read name and age:
#include <iostream>
#include <string>

using namespace std;

int main() {
    cout << "please enter your first name and age" << endl;
    string first_name;  // string variable
    int age;  // integer variable
    cin >> first_name >> age;  // read
    cout << "Hello, " << first_name << " age " << age << endl;
}
