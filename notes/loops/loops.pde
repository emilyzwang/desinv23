/*
* Emily Wang
* 6.12.19
* Class exercise: loops
*/

//runs once
void setup(){
  size(800,800);
  //fullScreen();
  background(150);
  
  //push/popMatrix()
  //for(int i = 800; i > 0; i /= 2) {
  //  pushMatrix();
  //  //translate(x, y);
  //  //beginShape();
  //  //endShape();
  //  translate(random(width), random(height));
  //  drawCircle(i, i);
  //  popMatrix();
  //}
  
  //nested loops
  for(int x = 0; x <= width; x += 100) {
    for(int y = 0; y <= height; y += 100) {
      pushMatrix();
      translate(x, y);
      drawCircle(40, 40);
      popMatrix();
    }
  }
}

//infinite loop
void draw(){
  //delay(ms);
}

void drawCircle(float w, float h){
  fill(random(255));
  ellipse(0, 0, w*1.5, h*1.5);
  fill(random(255));
  ellipse(0, 0, w, h);
}
