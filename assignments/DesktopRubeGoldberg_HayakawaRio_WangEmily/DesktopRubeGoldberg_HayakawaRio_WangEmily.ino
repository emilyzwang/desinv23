int pinStart = 13;
int pinEnd = 7;
long startTime;
int wait = 500;
boolean ledDone = false;

int sensorPin = A0;
int solenoidPin = 3;

void setup() {
  Serial.begin(9600);
  pinMode(solenoidPin, OUTPUT);
  for (int i = pinEnd; i <= pinStart; i++) {
    pinMode(i, OUTPUT);
  }
  startTime = millis();
}

void loop() {
  int sensorValue = analogRead(sensorPin);
  Serial.println(sensorValue);
  if (sensorValue < 970) {
    ledRow();
  }
  if (ledDone) {
    // solenoid pushes a stylus to take a photo, then releases
    digitalWrite(solenoidPin, HIGH);
    delay(1000);
    digitalWrite(solenoidPin, LOW);
    delay(10000);
  } else {
    digitalWrite(solenoidPin, LOW);
  }
}

/*
 * lights up a row of LEDs one by one, waiting .5 seconds between each
 */
void ledRow() {
  if ((startTime + wait) < millis()) {
    digitalWrite(pinStart, HIGH);
    startTime = millis();
    if (pinStart > pinEnd) {
      pinStart--;
    } else {
      ledDone = true;
    }
  }
}
