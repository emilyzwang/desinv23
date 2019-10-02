class Ball {
  float size;
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Ball(int size, PVector loc, PVector vel, PVector acc) {
    this.size = size;
    location = loc;
    velocity = vel;
    acceleration = acc;
  }
  
  Ball() {
    this.size = 50;
    this.location = new PVector(width/2, height/2);
    this.velocity = new PVector(random(-2, 2), random(-2, 2));
    this.acceleration = new PVector(0.01, 0.01);
  }
  
  void create() {
    circle(location.x, location.y, size);
  }
  
  void move() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector force = PVector.sub(location, mouse);
    force.normalize();
    force.mult(0.2);
    acceleration = force;
    
    velocity.add(acceleration);
    velocity.limit(10);
    bounce();
    location.add(velocity);
    create();
  }
  
  void bounce() {
    if (location.x > width - size/2 || location.x < size/2) {
      velocity.x *= -1;
      acceleration.x *= -1;
    }
    if (location.y > height - size/2 || location.y < size/2) {
      velocity.y *= -1;
      acceleration.y *= -1;
    }
  }
}
