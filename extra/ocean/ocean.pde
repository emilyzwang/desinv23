/*
* shark chasing fish
* Emily Wang
* 6.24.19
*/

ArrayList<Fish> fish;
Shark s;

void setup() {
  size(800, 800);
  ellipseMode(CENTER);
  noStroke();
  background(0);
  fish = new ArrayList<Fish>();
  generateFish();
  createShark();
}

void draw() {
  background(0);
  for (Fish f : fish) {
    f.move();
    f.display();
  }
  s.move();
  s.display();
}

void generateFish() {
  for (int i = 0; i < 100; i++) {
    Fish f = new Fish(new PVector(random(width), random(height)), 
                new PVector(random(-2, 2), random(-2, 2)), 
                new PVector(0.01, 0.01), 50, #ffffff);
    fish.add(f);
    f.display();
  }
}

void createShark() {
  s = new Shark();
  s.display();
}
