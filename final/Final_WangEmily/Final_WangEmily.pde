/*
 * Projection Mapping: Space
 * Emily Wang
 * 8.16.19
 */

import processing.serial.*;
Serial myPort;

Platform A;
Platform B;
Platform C;

void setup() {
  size(1500, 1500);
  background(0);
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
  // platforms as spaceships
  A = new Platform();
  B = new Platform();
  C = new Platform();
  
  myPort.bufferUntil('\n');
}

void draw() {
  background(0);
  
  drawBackground();
  
  A.display();
  B.display();
  C.display();
}

// moving through space
void drawBackground() {
  
}

// reading Arduino serial output for locations of the platforms 
// based on positions of the stepper motors
void serialEvent(Serial myPort) {
  String input = myPort.readStringUntil('\n');
  float position = float(myPort.readStringUntil('\n'));
  switch(input) {
    case "A":
      A.update(position);
    case "B":
      B.update(position);
    case "C":
      C.update(position);
  }
}
