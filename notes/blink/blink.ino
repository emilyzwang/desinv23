/*
 * note: output
 * Emily Wang
 * 7.15.19
 */

int ledPin = 13;
long lastTriggeredTime;
int onTime;
int offTime;
boolean ledBlink;

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);

  Serial.begin(9600);
  lastTriggeredTime = millis();
  onTime = 1000;
  offTime = 1000;
}

void loop() {
  if (Serial.available()) {
    char incomingData = Serial.read();
    Serial.print(incomingData);
    if (incomingData == '1') {
      ledBlink = true;
    } else if (incomingData == '0') {
      ledBlink = false;
    }
  }

  if (ledBlink) {
    blinkLED();
  } else {
    turnOffLED();
  }
}

void blinkLED() {
  if (millis() < lastTriggeredTime + onTime) {
    digitalWrite(ledPin, HIGH);
  } else if (millis() < lastTriggeredTime + offTime + onTime) {
    digitalWrite(ledPin, LOW);
  } else {
    lastTriggeredTime = millis();
  }
}

void turnOffLED() {
  digitalWrite(ledPin, LOW);
  lastTriggeredTime = millis();
}
