/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
float backgroundColor = 0;
boolean showSquare = false;
float circleRadius = 100;

void setup() 
{
  size(800, 800);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.    
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
  
  rectMode(CENTER);
  ellipseMode(CENTER);
}

void draw()
{
  background(backgroundColor);
  circle(width/2, height/2, circleRadius);
  if (showSquare) {
    rect(width/2, height/2, 100, 100);
  }
}

void serialEvent(Serial myPort) {
  String incomingData = myPort.readStringUntil('\n');
  if (incomingData.charAt(0) == 'A') {
    backgroundColor = float(incomingData.substring(1));
    circleRadius = float(incomingData.substring(1));
  } else if (incomingData.charAt(1) == '0') {
    showSquare = true;
  } else {
    showSquare = false;
  }
}

/*

// Wiring / Arduino Code
// Code for sensing a switch status and writing the value to the serial port.

int switchPin = 4;                       // Switch connected to pin 4

void setup() {
  pinMode(switchPin, INPUT);             // Set pin 0 as an input
  Serial.begin(9600);                    // Start serial communication at 9600 bps
}

void loop() {
  if (digitalRead(switchPin) == HIGH) {  // If switch is ON,
    Serial.write(1);               // send 1 to Processing
  } else {                               // If the switch is not ON,
    Serial.write(0);               // send 0 to Processing
  }
  delay(100);                            // Wait 100 milliseconds
}

*/
