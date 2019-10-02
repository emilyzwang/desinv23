/*
* Emily Wang
* 6.12.19
* Class exercise: recreating https://www.instagram.com/p/BxlFCJan2h5/
*/

color[] colors = {#FFFFFF, #B5D8F2, #5BACE8,#3E88BF, #000000};

void setup() {
  size(800,800);
  noStroke();
  frameRate(5);
  //int gridSize = 20;
  //float llimit = 0;
  //float ulimit = 1.5;
  //for(int y = 0; y <= height; y += gridSize) {
  //  for(int x = 0; x <= width; x += gridSize) {
  //    pushMatrix();
  //    translate(x, y);
  //    fill(colors[(int)random(llimit, ulimit)]); //casting to an int; or use floor()
  //    drawSquare(gridSize, gridSize);
  //    fill(colors[(int)random(llimit, ulimit)]);
  //    drawDiamond(gridSize, gridSize);
  //    fill(colors[(int)random(llimit, ulimit)]);
  //    drawCircle(gridSize/2, gridSize/2);
  //    popMatrix();
  //  }
  //  llimit = min(llimit + 0.035, 2);
  //  ulimit = min(ulimit + 0.075, 4);
  //}
}

void draw() {
  int gridSize = 20;
  float llimit = 0;
  float ulimit = 1.5;
  for(int y = 0; y <= height; y += gridSize) {
    for(int x = 0; x <= width; x += gridSize) {
      pushMatrix();
      translate(x, y);
      fill(colors[(int)random(llimit, ulimit)]); //casting to an int; or use floor()
      drawSquare(gridSize, gridSize);
      fill(colors[(int)random(llimit, ulimit)]);
      drawDiamond(gridSize, gridSize);
      fill(colors[(int)random(llimit, ulimit)]);
      drawCircle(gridSize/2, gridSize/2);
      popMatrix();
    }
    llimit = min(llimit + 0.075, 3);
    ulimit = min(ulimit + 0.095, 5);
  }
}

void drawCircle(float w, float h) {
  ellipse(0, 0, w, h);
}

void drawSquare(float w, float h) {
  rectMode(CENTER);
  rect(0, 0, w, h);
}

void drawDiamond(float w, float h){
  beginShape();
  vertex(0, -h/2);
  vertex(w/2, 0);
  vertex(0, h/2);
  vertex(-w/2, 0);
  endShape(CLOSE);
}
