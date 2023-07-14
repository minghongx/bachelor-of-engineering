#define A  0
#define B  1
#define C  2
#define D  3
#define E  4
#define F  5
#define G  6

const uint8_t SSDTruthTable[10][7] =
{
//   A     B     C     D     E     F     G          digit   index
    {HIGH, HIGH, HIGH, HIGH, HIGH, HIGH, LOW },  // Zero    [0]
    {LOW , HIGH, HIGH, LOW , LOW , LOW , LOW },  // One     [1]
    {HIGH, HIGH, LOW , HIGH, HIGH, LOW , HIGH},  // Two     [2]
    {HIGH, HIGH, HIGH, HIGH, LOW , LOW , HIGH},  // Three   [3]
    {LOW , HIGH, HIGH, LOW , LOW , HIGH, HIGH},  // Four    [4]
    {HIGH, LOW , HIGH, HIGH, LOW , HIGH, HIGH},  // Five    [5]
    {HIGH, LOW , HIGH, HIGH, HIGH, HIGH, HIGH},  // Six     [6]
    {HIGH, HIGH, HIGH, LOW , LOW , LOW , LOW },  // Seven   [7]
    {HIGH, HIGH, HIGH, HIGH, HIGH, HIGH, HIGH},  // Eight   [8]
    {HIGH, HIGH, HIGH, HIGH, LOW , HIGH, HIGH},  // Nine    [9]    
};

void DisplayUnitsDigit(int units_digit) {
    digitalWrite( 0,  SSDTruthTable[units_digit][A]);
    digitalWrite( 1,  SSDTruthTable[units_digit][B]);
    digitalWrite( 2,  SSDTruthTable[units_digit][C]);
    digitalWrite( 3,  SSDTruthTable[units_digit][D]);
    digitalWrite( 4,  SSDTruthTable[units_digit][E]);
    digitalWrite( 5,  SSDTruthTable[units_digit][F]);
    digitalWrite( 6,  SSDTruthTable[units_digit][G]);
}

void DisplayTensDigit(int tens_digit) {
    digitalWrite( 7,  SSDTruthTable[tens_digit][A]);
    digitalWrite( 8,  SSDTruthTable[tens_digit][B]);
    digitalWrite( 9,  SSDTruthTable[tens_digit][C]);
    digitalWrite(10,  SSDTruthTable[tens_digit][D]);
    digitalWrite(11,  SSDTruthTable[tens_digit][E]);
    digitalWrite(12,  SSDTruthTable[tens_digit][F]);
    digitalWrite(13,  SSDTruthTable[tens_digit][G]);
}

void DispalyDigitFrom00To99(int digit) {
    DisplayTensDigit(digit/10);
    DisplayUnitsDigit(digit%10);
}

void setup() {
    for (int pin = 0; pin <= 13; ++pin) 
        pinMode(pin, OUTPUT);
}

void loop() {
    for (int second = 0; second < 60; ++second) {    
        DispalyDigitFrom00To99(second);
        delay(1000);
    }
}
