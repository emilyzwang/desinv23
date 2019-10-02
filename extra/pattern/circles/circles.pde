/*
* Motif & Pattern
* Emily Wang
* 6.17.19
*/

//rotation: translate origin to center of shape first, then rotate by radians, then draw shape
int gridSize = 100;
color[] colors = {#AA0505, #F24E4E, #F58A8A, #F7C8C8};

void setup() {
  size(800, 800);
  int i = -width;
  colorMode(HSB);
  for (int y = 0; y <= height; y += gridSize/2) {
    for (int x = i; x <= width; x += gridSize) {
      pushMatrix();
      translate(x, y);
      drawSemiCircle(gridSize, colors[int(random(4))]);
      popMatrix();
    }
    i += gridSize/2;
  }
}

void draw() {
}

void drawSemiCircle(int size, color c) {
  stroke(c);
  fill(255);
  circle(0, 0, size);
  int r = int(random(4));
  switch (r) {
    case (0):
      pattern(c, 1, 0, 1);
      break;
    case (1):
      pattern(c, 1, 0.5, 1);
      break;
    case(2):
      pattern(c, int(random(2, 11)), 0, 10);
      break;
    //default:
    //  pattern4();
    //  break;
  }
}

void pattern(color c, int r, float s, float b) {
  for (int i = gridSize; i > 0; i -= r) {
    c = color(hue(c), saturation(c) + s, brightness(c) + b);
    stroke(c);
    noFill();
    circle(0, 0, i);
  }
}
