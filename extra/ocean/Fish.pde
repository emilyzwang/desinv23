class Fish {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int size;
  color c;
  
  Fish(PVector loc, PVector vel, PVector acc, int s, color col) {
    location = loc;
    velocity = vel;
    acceleration = acc;
    size = s;
    c = col;
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(PI + velocity.heading());
    fill(c);
    triangle(size/2, 0, 40, -15, 40, 15);
    ellipse(0, 0, size, size/2);
    popMatrix();
  }
  
  void move() {
    PVector mouse = new PVector(mouseX, mouseY);
    acceleration = PVector.sub(location, mouse);
    acceleration.normalize();
    acceleration.mult(0.2);
    
    velocity.add(acceleration);
    velocity.limit(10);
    
    checkEdges();
    location.add(velocity);
  }
  
  void checkEdges() {
    if (location.x < 0 || location.x > width) {
      velocity.x *= -1;
    }
    if (location.y < 0 || location.y > height) {
      velocity.y *= -1;
    }
  }
}
