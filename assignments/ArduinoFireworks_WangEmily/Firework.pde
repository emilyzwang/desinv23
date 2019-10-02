class Firework {
  PVector center;
  PVector location;
  float size;
  boolean explode;
  int counter;
  boolean active;
  color col;
  
  Firework(PVector c, float s, color col) {
    center = c;
    location = new PVector(c.x, height);
    size = s;
    explode = false;
    counter = 0;
    active = true;
    this.col = col;
  }
  
  void update() {
    if (counter > size) {
      active = false;      
    } else if (explode) {
      counter++;
      explode();
    } else if (PVector.sub(location, center).mag() < 5) {
      explode = true;
      explode();
    } else {
      shoot();
    }
  }
  
  void shoot() {
    location.y -= 5;
    fill(255);
    circle(location.x, location.y, 10);
  }
  
  void explode() {
    pushMatrix();
    translate(center.x, center.y);
    fill(col);
    circle(0, -counter, 5);
    for (float deg = 0; deg <= 2 * PI; deg += PI/16) {
      rotate(deg);
      circle(0, -counter, 5);
    }
    popMatrix();
  }
}
