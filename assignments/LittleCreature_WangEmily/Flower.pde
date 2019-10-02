/**
* class to define and create a flower object
*/
class Flower {
  PVector location;
  float size;
  color bud;
  color petals;
  
  Flower(PVector loc, float s, color bud, color petals) {
    location = loc;
    size = s;
    this.bud = bud;
    this.petals = petals;
  }
  
  //no argument constructor
  Flower() {
    location = new PVector(mouseX, mouseY);
    size = random(50, 100);
    bud = #6F5125;
    petals = #F5D468;
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    drawBud();
    drawPetals(size, 0);
    popMatrix();
  }
  
  void drawBud() {
    fill(bud);
    circle(0, 0, size);
    strokeWeight(2);
    stroke(hue(bud), saturation(bud), brightness(bud) - 20);
    drawLines();
    rotate(PI/2);
    drawLines();
    rotate(-PI/2);
  }
  
  //grid-style lines across the bud
  void drawLines() {
    for (float y = -size/2; y <= size/2; y += 10) {
      line(-size/2, y, size/2, y);
    }
  }
  
  void drawPetals(float r, float start) {
    fill(petals);
    stroke(hue(petals), saturation(petals), brightness(petals) - 20);
    for (float deg = start; deg <= (2 * PI) + start; deg += PI/16) {
      rotate(deg % (2 * PI));
      drawPetal(r);
    }
  }
  
  void drawPetal(float r) {
    pushMatrix();
    translate(0, -r/2);
    //petal shape
    //source: https://programmingdesignsystems.com/shape/custom-shapes/index.html
    beginShape();
    vertex(-10, 0);
    quadraticVertex(-20, -size/2, 0, -size);
    quadraticVertex(20, -size/2, 10, 0);
    endShape(CLOSE);
    popMatrix();
  }
}
