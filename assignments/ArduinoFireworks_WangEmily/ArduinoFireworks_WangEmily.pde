/*
* Assignment 5: Arduino Fireworks
* Emily Wang
* 7.13.19
*/

import processing.serial.*;

Serial myPort;

ArrayList<Firework> fireworks;

void setup() {
  size(800, 800);
  background(0);
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
  noStroke();
  fill(255);
  colorMode(HSB, 360, 100, 100);
  
  fireworks = new ArrayList();
  
  myPort.bufferUntil('\n');
}

void draw() {
  fill(0, 20);
  rect(0, 0, width, height);
  for (int i = 0; i < fireworks.size(); i++) {
    if (fireworks.get(i).active) {
      fireworks.get(i).update();
    }
  }
  
}

void serialEvent(Serial myPort) {
  float input = float(myPort.readStringUntil('\n'));
  color col = color(random(360), 100, 100);
  if (input == 10) {
    PVector l = new PVector(random(width), random(height/2));
    myPort.write(int(1200 - l.y));
    fireworks.add(new Firework(l, random(50, 100), col));
  } else if (input == 20) {
    PVector l = new PVector(random(width), random(height/2, height));
    myPort.write(int(800 - l.y));
    fireworks.add(new Firework(l, random(100, 200), col));
  }
}
