#include <AccelStepper.h>

AccelStepper stepperA(AccelStepper::DRIVER, 12, 11);
AccelStepper stepperB(AccelStepper::DRIVER, 6, 5);
AccelStepper stepperC(AccelStepper::DRIVER, 9, 8);

int switchPinA = 13;
int switchPinB = 7;
int switchPinC = 10;

class Track {
  private:
    AccelStepper *stepper;
    int switchPin;
    boolean forward;
    int len;
    int motorSpeed;

  public:
    // constructor
    Track(AccelStepper *s, int sPin, boolean f, int sp, int l) {
      stepper = s;
      switchPin = sPin;
      forward = f;
      len = l;
      motorSpeed = sp;

//      stepper->setCurrentPosition(len);
      stepper->setMaxSpeed(motorSpeed);
      stepper->setAcceleration(motorSpeed);
      stepper->setSpeed(motorSpeed);
    }

    // turn stepper based on direction and location/switch press
    // returns position to send to Processing sketch
    int go() {
      if (forward) {
        if (digitalRead(switchPin) == 0) {
          stepper->stop();
          forward = false;
          stepper->setCurrentPosition(0);
          stepper->moveTo(len);
        } else {
          stepper->runSpeed();
        }
      } else if (stepper->distanceToGo() < 0) {
        stepper->setSpeed(-motorSpeed);
        stepper->runSpeed();
      } else {
        stepper->stop();
        forward = true;
        stepper->setSpeed(motorSpeed);
      }
      
      return stepper->currentPosition();
  }
};

Track *trackA = new Track(&stepperA, switchPinA, true, 3000, -18000);
Track *trackB = new Track(&stepperB, switchPinB, true, 4000, -18000);
Track *trackC = new Track(&stepperC, switchPinC, true, 5000, -18000);

void setup() {
  pinMode(switchPinA, INPUT_PULLUP);
  pinMode(switchPinB, INPUT_PULLUP);
  pinMode(switchPinC, INPUT_PULLUP);

  Serial.begin(9600);
}

void loop() {
  trackA->go();
  trackB->go();
  trackC->go();
//  Serial.println("A");
//  Serial.println(trackA->go());
//    
//  Serial.println("B");
//  Serial.println(trackB->go());
//
//  Serial.println("C");
//  Serial.println(trackC->go());

// old code that only worked for one track at a time

//  stepper.setSpeed(1000);
//  while (digitalRead(switchPin) == 1) {
//    stepper.runSpeed();
//  }
//  stepper.stop();
//  stepper.setCurrentPosition(0);
//  stepper.moveTo(-18000);
//
//  while (stepper.distanceToGo() < 0) {
//    stepper.run();
//  }
//  stepper.stop();
}
