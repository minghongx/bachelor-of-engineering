// FIXME: Bad code style. Should follow Google C++ Style Guide

#include <IRremote.h>

#define lfEN 9
#define lf1A 3
#define lf2A 2
#define rgEN 10
#define rg3A 5
#define rg4A 6

#define RECV 7

int distance, slowDownDistance, brakeDistance;

IRrecv irrecv(RECV);
decode_results results;

void setup() {
  
  pinMode(lfEN, OUTPUT);
  pinMode(lf1A, OUTPUT);
  pinMode(lf2A, OUTPUT);
  pinMode(rgEN, OUTPUT);
  pinMode(rg3A, OUTPUT);
  pinMode(rg4A, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);

  irrecv.enableIRIn();
  irrecv.blink13(true);
  
  Serial.begin(9600);
  
}

void loop() {
  
  // Remote control
  if ( irrecv.decode(&results) ) {
    switch (results.value) {
      
      case 0xFD08F7:  // 1: foward slowly
      forward(100);
      break;
      
      case 0xFD8877:  // 2: backward slowly
      reverse(100);
      break;
      
      case 0xFD48B7:  // 3: foward fastly
      forward(255);
      break;
      
      case 0xFD28D7:  // 4: backward fastly
      reverse(255);
      break;
      
      case 0xFDA857:  // 5: brake
      brake();
      break;
      
    }
    
    irrecv.resume();
  }
  
  // Slow down and stop when danger close
  slowDownDistance = 100;
  brakeDistance = 50;
  distance = 0.03204154 * readUltrasonicDistance(8, 8);
  Serial.println(distance);
  if (distance > slowDownDistance) {  // No danger
    digitalWrite(11, LOW);
    digitalWrite(12, LOW);
  }
  if (distance <= slowDownDistance && distance >= brakeDistance) {  // Slow down within [slowDownDistance, brakeDistance]
    digitalWrite(11, HIGH);
    digitalWrite(12, LOW);
    changeRate(30);  // Slow down
  }
  if (distance < brakeDistance) {  // Brake within [0, brakeDistance)
    digitalWrite(11, HIGH);
    digitalWrite(12, HIGH);
    brake();
  }
  
}

void forward(int rate) {
  
  // Left motor
  digitalWrite(lfEN, LOW);  // Turn off the dirver before reset its input
  digitalWrite(lf2A, HIGH);
  digitalWrite(lf1A, LOW);
  analogWrite(lfEN, rate);
  
  // Right motor
  digitalWrite(rgEN, LOW);
  digitalWrite(rg3A, HIGH);
  digitalWrite(rg4A, LOW);
  analogWrite(rgEN, rate);
  
}

void reverse(int rate) {
  
  // Left
  digitalWrite(lfEN, LOW);
  digitalWrite(lf2A, LOW);
  digitalWrite(lf1A, HIGH);
  analogWrite(lfEN, rate);
  
  // Right
  digitalWrite(rgEN, LOW);
  digitalWrite(rg3A, LOW);
  digitalWrite(rg4A, HIGH);
  analogWrite(rgEN, rate);
  
}

void brake() {
  
  // Left
  digitalWrite(lfEN, LOW);
  digitalWrite(lf2A, LOW);
  digitalWrite(lf1A, LOW);
  analogWrite(lfEN, HIGH);
  
  // Right
  digitalWrite(rgEN, LOW);
  digitalWrite(rg3A, LOW);
  digitalWrite(rg4A, LOW);
  analogWrite(rgEN, HIGH);
  
}

void changeRate(int rate) {

  // Left
  digitalWrite(lfEN, LOW);
  analogWrite(lfEN, rate);
  
  // Right
  digitalWrite(rgEN, LOW);
  analogWrite(rgEN, rate);

}

long readUltrasonicDistance(int triggerPin, int echoPin) {
  pinMode(triggerPin, OUTPUT);  // Clear the trigger
  digitalWrite(triggerPin, LOW);
  delayMicroseconds(2);
  // Sets the trigger pin to HIGH state for 10 microseconds
  digitalWrite(triggerPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(triggerPin, LOW);
  pinMode(echoPin, INPUT);
  // Reads the echo pin, and returns the sound wave travel time in microseconds
  return pulseIn(echoPin, HIGH);
}
