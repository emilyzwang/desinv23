/*
* Assignment 2: Motif & Pattern
* Emily Wang
* 6.17.19
*/

//used by multiple functions, so declared globally
int gridSize = 100;

void setup() {
  size(800, 800);
  background(255);
  colorMode(HSB, 360, 100, 100, 1000);
  noStroke();
  //defines color for entire quilt
  color c = color(238, 60, 86);
  for (int y = -gridSize; y <= height + gridSize; y += gridSize / 2) {
    for (int x = -gridSize; x <= width; x += gridSize) {
      //limits alpha value for more transparent top left and more opaque bottom right
      int limit = x * y / 1400;
      pushMatrix();
      //two overlapping grids of rhombus shapes with different orientations
      translate(x, y);
      drawRhombus(c, PI/4, limit);
      //offset by half a grid
      translate(-gridSize/2, 0);
      drawRhombus(c, -PI/4, limit);
      popMatrix();
    }
  }
  //border
  strokeWeight(2);
  c = color(hue(c), saturation(c) * 2, brightness(c), 400);
  //horizontal top
  makeBorder(0, 0, 0, c);
  //vertical left
  makeBorder(0, height, -PI/2, c);
  c = color(hue(c), saturation(c) / 4, brightness(c) * 2, 600);
  //horizontal bottom
  makeBorder(width, height, PI, c);
  //vertical right
  makeBorder(width, 0, PI/2, c);
  save("MotifAndPattern_WangEmily.png");
}

void drawRhombus(color c, float s, int limit) {
  fill(hue(c), saturation(c), brightness(c), random(limit, 100 + limit));
  //shears by s radians around the y-axis to create rhombus shape
  shearY(s);
  rect(0, 0, gridSize, gridSize);
  //resets to no shearing
  shearY(-s);
}

//generates one shape, rotated differently for each side
void makeBorder(int xStart, int yStart, float rotation, color c) {
  stroke(c);
  fill(c);
  pushMatrix();
  translate(xStart, yStart);
  rotate(rotation);
  //trapezoid shape
  quad(0, 0, width, 0, width - gridSize/2, gridSize/2, gridSize/2, gridSize/2);
  popMatrix();
}
