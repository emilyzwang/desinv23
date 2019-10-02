class Shark extends Fish {
  float rotation;
  
  Shark() {
    super(new PVector(width/2, height/2), null, null, 200, #82AADE);
    rotation = 0;
  }
  
  void move() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector diff = PVector.sub(location, mouse);
    if (diff.mag() > 0.5) {
      rotation = diff.heading();
      location = mouse;
    }
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    print(location.x, location.y);
    rotate(rotation);
    fill(c);
    ellipse(0, 0, size, size/2);
    triangle(50, 0, 150, -50, 150, 50);
    popMatrix();
  }
}
