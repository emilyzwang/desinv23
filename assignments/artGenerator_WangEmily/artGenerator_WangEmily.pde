/*
* Assignment 01: Art Generator
* Emily Wang
* 6.12.19
*/

void setup() {
  size(400, 400);
  noStroke();
  // 1. split into two sections with a diagonal line
  // 2. fill both sections with different colors of the same hue
  colorMode(HSB,360,100,100);
  color c1 = color(random(360), 60, 30);
  color c2 = color(hue(c1), 90, 80);
  int i = (int)random(2);
  makeSections(i, c1, c2);
  float start = random(width);
  float end = random(width);
  // 3. add a triangle aligned with an edge, fill with a shade in between
  int j = (int)random(4);
  fill(lerpColor(c1,c2,random(1)));
  if(j == 0) {
    triangle(0,random(height),0,random(height),random(width),random(height));
  } else if(j == 1) {
    triangle(random(width),0,random(width),0,random(width),random(height));
  } else if (j == 2) {
    triangle(width,random(height),width,random(height),random(width),random(height));
  } else {
    triangle(random(width),height,random(width),height,random(width),random(height));
  }
  // 4. add two parallel bright lines across
  int k = (int)random(2);
  strokeWeight(random(3,10));
  stroke(hue(c1),90,100);
  float l = random(width);
  float dist = random(width/10);
  if(k == 0) {
    line(0,l,width,l);
    line(0,l+dist,width,l+dist);
  } else {
    line(l,0,l,height);
    line(l+dist,0,l+dist,height);
  }
  // 5. add a white border
  noFill();
  strokeWeight(30);
  stroke(color(0,0,100));
  rect(0,0,width,height);
  // 6. add 2 squiggly lines from one corner to a diagonal line
  if(i == 0) {
    noStroke();
    line(0,0, 0,height);
    line(start,0, end,height);
    stroke(0,0,100);
    strokeWeight(10);
    noFill();
    bezier(0,0, start,height/3, 0,height*2/3, end,height);
    float d = random(20,30);
    bezier(0-d,d, start-d,height/3, 0-d,height*2/3, end-d,height+d);
  } else {
    noStroke();
    line(0,0, width,0);
    line(0,start, width,end);
    stroke(0,0,100);
    strokeWeight(10);
    noFill();
    bezier(0,0, width/3,start, width*2/3,0, width,end);
    float d = random(20,30);
    bezier(0+d,-d, width/3,start-d, width*2/3,-d, width+d,end-d);
  }
  save("pic11.png");
}

void makeSections(int i, color c1, color c2) {
  float start = random(width);
  float end = random(width);
  if(i == 0) {
    fill(c1);
    quad(0,0, width,0, width,start, 0,end);
    fill(c2);
    quad(0,end, width,start, width,height, 0,height);
  } else {
    fill(c1);
    quad(0,0, start,0, end,height, 0,height);
    fill(c2);
    quad(start,0, width,0, width,height, end,height);
  }
}
