// FIXME: Bad code syle. Should follow Google C++ Style Guide

const int pirPin = 2;
const int relayEnergizerPin = 3;
const int fsrPin = 0;

int fsrReading;
int pirStat = 0;
bool latch = false;  // a weird flag used to lock system status

void setup() {
  
  pinMode(pirPin, INPUT);
  pinMode(relayEnergizerPin, OUTPUT);
  
  Serial.begin(9600);
}

void loop() {
  
  fsrReading = analogRead(fsrPin);
  pirStat = digitalRead(pirPin); 
  
  Serial.print(pirStat);
  Serial.print("\t");
  Serial.print(latch);
  Serial.print("\t");
  Serial.print(fsrReading);
  Serial.print("\n");
  
  // Move, or locked and >= 6.92N,
  if ( (pirStat == HIGH) || (latch == true && fsrReading > 400) ) {
    digitalWrite(relayEnergizerPin, HIGH);
	  if (latch == false) latch = true;
  }
  
  // 1e4 ms tolerance if latch was locked before
  if (latch == true) delay(1e4);
  
  // Not move and not sit: Human has leaved
  if (pirStat == LOW && fsrReading <= 400) {
    digitalWrite(relayEnergizerPin, LOW);
    latch = false;
  }
  
  delay(100);
}
