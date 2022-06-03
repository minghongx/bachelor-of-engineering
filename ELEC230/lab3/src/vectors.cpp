// compute mean (average) and median temperatures:
#include "std_lib_facilities.h"

int main() {
    vector<double> temps;  // temperatures in Fahrenheit, e.g. 64.6
    double temp;
    while (cin>>temp) temps.push_back(temp);  // read and put into vector
    double sum = 0;
    for (int i = 0; i < temps.size(); ++i) sum += temps[i];  // sums temperatures
    cout << "Mean temperature: " << sum/temps.size() << endl;
    sort(temps.begin(), temps.end());
    cout << "Median temperature: " << temps[temps.size()/2] << endl;
}
