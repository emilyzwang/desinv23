/*
* lights on the ferris wheel
*/

import spout.*;

Spout spout;
PGraphics pgr;
color c;
float start;
float startSpokes;

void setup() {
  size(800, 800, P3D);
  background(0);
  c = #FFE203;
  fill(c);
  
  pgr = createGraphics(1280, 720, P3D);
  
  spout = new Spout(this);
  spout.createSender("Spout Processing 2");
  
  colorMode(HSB, 360, 100, 100);
  
  start = 0;  
  startSpokes = 0;
  drawWheel();
  drawSpokes();
  
  frameRate(10);
}

void draw() {
  background(0);
    
  drawWheel();
  drawSpokes();
  
  spout.sendTexture();
}

void mouseClicked() {
  c = color(random(360), 99, 99);
}

void drawWheel() {
  pushMatrix();
  translate(width/2, height/2);
  rotate(start);
  color col = c;
  for (float deg = start; deg < (2 * PI) + start; deg += PI/32) {
    circle(0, -300, 15);
    rotate(PI/32);
    col = color(hue(col), saturation(col) - 2, brightness(col));
    fill(col);
  }
  popMatrix();
  start += PI/32;
}

void drawSpokes() {
  pushMatrix();
  translate(width/2, height/2);
  rotate(PI/20);
  for (float deg = 0; deg < (2 * PI); deg += PI/5) {
    drawSpoke();
    rotate(PI/5);
  }
  popMatrix();
  startSpokes += 20;
}

void drawSpoke() {
  color col = c;
  for (float i = startSpokes; i < 300 + startSpokes; i += 20) {
    fill(col);
    circle(0, -(i % 300), 10);
    col = color(hue(col), saturation(col) - 15, brightness(col));
  }
}
