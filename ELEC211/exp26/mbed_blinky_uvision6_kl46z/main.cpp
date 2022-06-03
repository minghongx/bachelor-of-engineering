#include "mbed.h"

DigitalOut led_1(LED1);
DigitalOut led_2(LED2);

int main() {
    while(1) {
        led_1 = 1;
				led_2 = 1;
        wait(0.2);
				led_1 = 0;
        led_2 = 0;
        wait(0.2);
    }
}
