/*
* Motif & Pattern
* Emily Wang
* 6.17.19
*/

//used by multiple functions, so declared globally
int gridSize = 100;
color[] colors = {#2E6BB4, #4F2EB4, #208AB2, #3134C1};

void setup() {
  size(800, 800);
  background(255);
  colorMode(HSB);
  ellipseMode(CENTER);
  //semicircle border
  //horizontal top
  makeBorder(gridSize, width, gridSize/2, gridSize, 0);
  //horizontal bottom (semicircles rotated 180deg)
  makeBorder(gridSize, width, height - gridSize/2, height, PI);
  //vertical left (semicircles rotated -90deg)
  makeBorder(gridSize/2, gridSize, gridSize, height, -PI/2);
  //vertical right (semicircles rotated 90deg)
  makeBorder(width - gridSize/2, width, gridSize, height, PI/2);
  //squares - grid layout
  for (int y = gridSize/2; y < height - gridSize; y += gridSize) {
    for (int x = gridSize/2; x < width - gridSize; x += gridSize) {
      pushMatrix();
      translate(x, y);
      drawSquare();
      popMatrix();
    }
  }
  save("MotifAndPattern_WangEmily7.png");
}

void draw() {
}

void makeBorder(int xStart, int xEnd, int yStart, int yEnd, float rotation) {
  for (int x = xStart; x < xEnd; x += gridSize) {
    for (int y = yStart; y < yEnd; y += gridSize) {
      pushMatrix();
      translate(x, y);
      rotate(rotation);
      drawSemiCircle(-PI, 0);
      popMatrix();
    }
  }
}

void drawSemiCircle(float start, float stop) {
  color c = colors[int(random(4))];
  stroke(c);
  fill(255);
  arc(0, 0, gridSize, gridSize, start, stop);
  noFill();
  //random style for pattern (radius increment, color gradient)
  int r = int(random(4));
  switch (r) {
    case (0):
      pattern(c, 1, 0, 1, start, stop);
      break;
    case (1):
      pattern(c, 1, 0.5, 1, start, stop);
      break;
    case(2):
      pattern(c, int(random(2, 11)), 0, 10, start, stop);
      break;
  }
}

void drawSquare() {
  color c = colors[int(random(4))];
  stroke(c);
  fill(255);
  rect(0, 0, gridSize, gridSize);
  noFill();
  //random orientation for pattern (corner to start in)
  int r = int(random(4));  
  switch (r) {
    case (0):
      rotate(PI/2);
      translate(0, -gridSize);
      break;
    case (1):
      rotate(PI);
      translate(-gridSize, -gridSize);
      break;
    case (2):
      rotate(-PI/2);
      translate(-gridSize, 0);
      break;
  }
  //random style for pattern (radius increment, color gradient, squares/dots)
  r = int(random(4));
  switch (r) {
    case (0):
      pattern2(c, 1, 0, 1);
      break;
    case (1):
      pattern2(c, 1, 0.5, 1);
      break;
    case (2):
      pattern2(c, int(random(2, 11)), 0, 10);
      break;
    case (3):
      pattern3(c, int(random(2, 11)), 1, 15);
  }
}

//colors are passed into pattern functions to keep same color as the shape's outline

//semicircle pattern
void pattern(color c, int r, float s, float b, float start, float stop) {
  for (int i = gridSize; i > 0; i -= r) {
    c = color(hue(c), saturation(c) + s, brightness(c) + b);
    stroke(c);
    arc(0, 0, i, i, start, stop);
  }
}

//square pattern: squares within squares, sharing a corner
void pattern2(color c, int r, float s, float b) {
  for (int i = gridSize; i > 0; i -= r) {
    c = color(hue(c), saturation(c) + s, brightness(c) + b);
    stroke(c);
    rect(0, 0, i, i);
  }
}

//square pattern: polka dots
void pattern3(color c, int r, float s, float b) {
  float w = random(15 - r);
  strokeWeight(w);
  for (int y = r; y <= gridSize - r; y += r) {
    for (int x = r; x <= gridSize - r; x += r) {
      c = color(hue(c), saturation(c) + s, brightness(c) + b);
      stroke(c);
      point(x, y);
    }
  }
  strokeWeight(1);
}

//not used
//square pattern: squares within squares, sharing a center
void pattern4(color c, int r, float s, float b) {
  rectMode(CENTER);
  pushMatrix();
  translate(gridSize/2, gridSize/2);
  for (int i = gridSize; i > 0; i -= r) {
    c = color(hue(c), saturation(c) + s, brightness(c) + b);
    stroke(c);
    rect(0, 0, i, i);
  }
  popMatrix();
  rectMode(CORNER);
}

//replaced by makeBorder(gridSize, width, y, --, rotation)
void makeBorderRow(int y, float rotation) {
  for (int x = gridSize; x < width; x += gridSize) {
    //rotation: translate origin to center of shape first, then rotate by radians, then draw shape
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    drawSemiCircle(-PI, 0);
    popMatrix();
  }
}

//replaced by makeBorder(x, --, gridSize, height, rotation)
void makeBorderColumn(int x, float rotation) {
  for (int y = gridSize; y < height; y += gridSize) {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    drawSemiCircle(-PI, 0);
    popMatrix();
  }
}
