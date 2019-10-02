#include <AccelStepper.h>

int switchPinA = 13;
int switchPinB = 7;
int switchPinC = 10;

class Track {
  private:
    AccelStepper stepper;
    int switchPin;
    boolean forward;
    int len;
    int motorSpeed;

  public:
    // constructor
    Track(int motorPin1, int motorPin2, int sPin, boolean f, int sp, int l) : stepper(AccelStepper::DRIVER, motorPin1, motorPin2) {
      switchPin = sPin;
      forward = f;
      len = l;
      motorSpeed = sp;

//      stepper.setCurrentPosition(len);
      stepper.setMaxSpeed(motorSpeed);
      stepper.setAcceleration(motorSpeed);
      stepper.setSpeed(motorSpeed);
    }

    // turn stepper based on direction and location/switch press
    // returns position to send to Processing sketch
    int go() {
      if (forward) {
        if (digitalRead(switchPin) == 0) {
          stepper.stop();
          forward = false;
          stepper.setCurrentPosition(0);
          stepper.moveTo(len);
        } else {
          stepper.runSpeed();
        }
      } else if (stepper.distanceToGo() < 0) {
        stepper.setSpeed(-motorSpeed);
        stepper.runSpeed();
      } else {
        stepper.stop();
        forward = true;
        stepper.setSpeed(motorSpeed);
      }
      
      return stepper.currentPosition();
  }
};

Track *trackA = new Track(12, 11, switchPinA, true, 1000, -18000);
Track *trackB = new Track(6, 5, switchPinB, true, 1500, -10000);
Track *trackC = new Track(9, 8, switchPinC, true, 2000, -18000);

void setup() {
  pinMode(switchPinA, INPUT_PULLUP);
  pinMode(switchPinB, INPUT_PULLUP);
  pinMode(switchPinC, INPUT_PULLUP);

  Serial.begin(9600);
}

void loop() {
//  Serial.println("A");
  Serial.println(trackA->go());
    
//  Serial.println("B");
  Serial.println(trackB->go());

//  Serial.println("C");
  Serial.println(trackC->go());
}
