/*
* Note: Oscillation & Random
* Emily Wang
* 6.17.19
*/

float x;
float y;
float xOff;
float yOff;

void setup() {
  size(800, 800);
  frameRate(10);
  x = 400;
  randomSeed(0);
  xOff = 0;
  yOff = 10;
}

void draw() {
  clear();
  background(255);
  //float offset = random(-5, 5);
  xOff += 0.01;
  yOff += 0.01;
  x = map(noise(xOff), 0, 1, 0, width); //creates bounds for noise too
  y = map(noise(yOff), 0, 1, 0, height);
  ellipse(x, y, 20, 20);
}
