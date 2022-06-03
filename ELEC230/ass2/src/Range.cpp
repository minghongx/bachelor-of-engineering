#include <fstream>
#include <iostream>
#include <unistd.h>
#include <ctime>
#include <chrono>

#include <VL53L1X.h>

using namespace std;

VL53L1X Distance_Sensor;

int main() {

    bool status;
    status = Distance_Sensor.begin();
//     cout << status << endl;

    ofstream datafile("./data.csv", ios::app);

    int sample_size = 100;
    Distance_Sensor.startMeasurement(); //Write configuration bytes to initiate measurement
//    clock_t begin = clock();
    auto begin = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < sample_size; ++i) {

        //Poll for completion of measurement. Takes 40-50ms.
        while (!Distance_Sensor.newDataReady()) {
            usleep(5);
            //cout << "DATA NOT READY" << endl;
        }

        int distance = Distance_Sensor.getDistance(); //Get the result of the measurement from the sensor
//        datafile << distance << endl;
        cout << "Distance(mm): " << distance << endl;

        Distance_Sensor.clearInterrupt();
    }
    auto end = std::chrono::high_resolution_clock::now();
//    clock_t end = clock();

    std::chrono::duration<double> time = end - begin;
    cout << "Time(s): " << time.count() << endl;

    auto sampling_rate = sample_size / time.count();
    cout << "Sampling Rate: " << sampling_rate << " per second" << endl;

    return 0;
}
