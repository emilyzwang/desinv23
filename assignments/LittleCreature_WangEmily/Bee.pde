/**
* class used to define, create, and move a bee object
*/
class Bee {
  PVector location;
  PVector velocity;
  float size;
  Flower flower;
  int numFlowers;
  boolean flyLoop;
  PVector center;
  PVector startV;
  
  Bee(PVector loc, PVector vel, float s) {
    location = loc;
    velocity = vel;
    size = s;
    numFlowers = 0;
    flyLoop = false;
  }
  
  //no argument constructor
  Bee() {
    location = getStartLocation();
    velocity = new PVector(random(-2, 2), random(-2, 2));
    size = random(30, 50);
  }
  
  PVector getStartLocation() {
    int r = int(random(4));
    switch(r) {
      //offscreen left
      case 0:
        return new PVector(random(-100, 0), random(-100, height + 100));
      //offscreen right
      case 1:
        return new PVector(random(width, width + 100), random(-100, height + 100));
      //offscreen top
      case 2:
        return new PVector(random(-100, width + 100), random(-100, 0));
      //offscreen bottom
      default:
        return new PVector(random(-100, width + 100), random(height, height + 100));
    }
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading() % (2 * PI));
    stroke(#000000);
    fill(#FADE0A);
    ellipse(0, 0, size, size/2);
    fill(#000000);
    beginShape();
      curveVertex(-size/16, size/4);
      curveVertex(-size/16, size/4);
      curveVertex(-size * 3/32, 0);
      curveVertex(-size/16, -size/4);
      curveVertex(-size/16, -size/4);
      curveVertex(0, -size/4);
      curveVertex(size/16, -size/4);
      curveVertex(size/16, -size/4);
      curveVertex(size/32, 0);
      curveVertex(size/16, size/4);
      curveVertex(size/16, size/4);
      endShape(CLOSE);
    beginShape();
      curveVertex(-size * 5/16, size * 13/64);
      curveVertex(-size * 5/16, size * 13/64);
      curveVertex(-size * 11/32, 0);
      curveVertex(-size * 5/16, -size * 3/16);
      curveVertex(-size * 5/16, -size * 3/16);
      curveVertex(-size/4, -size * 7/32);
      curveVertex(-size * 3/16, -size * 15/64);
      curveVertex(-size * 3/16, -size * 15/64);
      curveVertex(-size * 7/32, 0);
      curveVertex(-size * 3/16, size * 15/64);
      curveVertex(-size * 3/16, size * 15/64);
      endShape(CLOSE);
    beginShape();
      curveVertex(size * 5/16, size * 13/64);
      curveVertex(size * 5/16, size * 13/64);
      curveVertex(size * 9/32, 0);
      curveVertex(size * 5/16, -size * 3/16);
      curveVertex(size * 5/16, -size * 3/16);
      curveVertex(size/4, -size * 7/32);
      curveVertex(size * 3/16, -size * 15/64);
      curveVertex(size * 3/16, -size * 15/64);
      curveVertex(size * 5/32, 0);
      curveVertex(size * 3/16, size * 15/64);
      curveVertex(size * 3/16, size * 15/64);
      endShape(CLOSE);
    line(-size/2, 0, -size * 5/8, 0);
    stroke(200, 12, 98, 80);
    fill(200, 10, 98, 60);
    translate(-size/4, -size/4);
    rotate(PI/8);
    ellipse(-size/8, -size/8, size * 5/8, size/3);
    rotate(PI/8);
    ellipse(-size/20, -size/4, size/2, size/3);
    popMatrix();
  }
  
  void moveTo(Flower f) {
    flower = f;
    if (numFlowers > flowers.size()) {
      fly(PVector.sub(location, flower.location), 0.15, 2);
      deadBees.add(this);
    }
    numFlowers++;
  }
  
  void move() {
    PVector mouse = new PVector(mouseX, mouseY);
    if (flyLoop) {
      checkLoop();
      fly(PVector.sub(center, location), 0.05, 2);
      //putting cursor near a bee makes it fly in a loop
    } else if (PVector.sub(mouse, location).mag() < 20) {
      flyLoop = true;
      center = new PVector(location.x, location.y - 50);
      startV = new PVector(velocity.x, velocity.y);
      fly(PVector.sub(center, location), 0.05, 2);
    } else {
     fly(PVector.sub(flower.location, location), 0.2, 2);
    }
  }
  
  //separate function than move() because
  //only flies in a straight line back to the "beehive" -- no more loops
  void flyAway() {
    fly(PVector.sub(location, flower.location), 0.15, 2); //away from the flower
  }
  
  void fly(PVector acceleration, float acc, float vel) {
    acceleration.normalize();
    acceleration.mult(acc);
    
    velocity.add(acceleration);
    velocity.limit(vel);
    location.add(velocity);
  }
  
  //checks to see if loop is completed based on initial direction traveling (start velocity)
  void checkLoop() {
    if (startV.x < 0) {
      if (center.x < location.x && center.y < location.y) {
        flyLoop = false;
      }
    } else if (center.x > location.x && center.y < location.y) {
      flyLoop = false;
    }
  }
}
