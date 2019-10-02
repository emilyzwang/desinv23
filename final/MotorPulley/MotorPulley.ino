#include <AccelStepper.h>

// Define stepper; pin 13 for step, pin 12 for dir
AccelStepper stepper(AccelStepper::DRIVER, 13, 12);

int switchPin = 11;

void setup()
{  

    pinMode(switchPin, INPUT_PULLUP);

  stepper.setMaxSpeed(1 000);
  stepper.setAcceleration(1000);
  // total length of the track: ???
//  stepper.setCurrentPosition(0);
  stepper.setSpeed(-1000);
  while(digitalRead(switchPin) == 1){
    stepper.runSpeed();
  }
  stepper.stop();
  stepper.setCurrentPosition(0);
  
  stepper.moveTo(18000);
}

void loop()
{
      stepper.run();

      if(stepper.distanceToGo() == 0){
        if(stepper.targetPosition() == 18000){
            stepper.moveTo(0);
        }else if(stepper.targetPosition() == 0){
          while(digitalRead(switchPin) == 1){
              stepper.setSpeed(-500);
              stepper.runSpeed();

          }
            stepper.stop();
            stepper.setCurrentPosition(0);
            stepper.moveTo(18000);
        }
      }

//    // If at the end of travel go to the other end
    if (digitalRead(switchPin) == 0) {
      stepper.stop();
      stepper.setCurrentPosition(0);
      stepper.moveTo(18000);
    }
//      stepper.set
//      stepper.moveTo(0);
//    } else if (stepper.currentPosition() == 0) {
//      stepper.moveTo(-12000);
//    }
//    stepper.run();
}
