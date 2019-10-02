/*
* Vectors
*/

PVector pointA;

void setup() {
  size(500, 500);
  pointA = new PVector (width/2, height/2);
  background(255);
}

void draw() {
  background(255);
  PVector mouse = new PVector(mouseX, mouseY);
  //static vector functions
  PVector diff = PVector.sub(pointA, mouse);
  PVector sum = PVector.add(pointA, mouse);
  //non-static vector add; returns none
  //pointA.add(diff); //changes pointA value by diff
  diff.normalize();
  diff.mult(5); //scale
  diff.mag(); //magnitude
  diff.limit(10);
  line(pointA.x, pointA.y, mouse.x, mouse.y);
  line(pointA.x, pointA.y, diff.x, diff.y);
  line(pointA.x, pointA.y, sum.x, sum.y);
  
  
}
