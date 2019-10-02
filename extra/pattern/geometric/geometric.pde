/*
* Motif & Pattern
* Emily Wang
* 6.17.19
*/

//rotation: translate origin to center of shape first, then rotate by radians, then draw shape
int gridSize = 100;

void setup() {
  size(800, 800);
  background(255);
  noFill();
  for (int y = 0; y <= height; y += gridSize) {
    for (int x = 0; x <= width; x += gridSize) {
      pushMatrix();
      translate(x, y);
      rectMode(CENTER);
      noStroke();
      square(0, 0, gridSize);
      strokeWeight(10);
      stroke(0);
      int r = int(random(4));
      beginShape();
      switch (r) {
        case 0:
          rotate(radians(90));
        case 1: 
          rotate(radians(180));
        case 2:
          rotate(radians(270));
      }
      line(-gridSize/2,0, 0,-gridSize/2);
      line(0,-gridSize/2, gridSize/2,0);
      line(0,-gridSize/2, 0,gridSize/2);
      popMatrix();
    }
  }
}

void draw() {
}
