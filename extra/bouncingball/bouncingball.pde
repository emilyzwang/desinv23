/*
* Class Exercise: Bouncing Ball
* Emily Wang
* 6.19.19
*/

ArrayList<Ball> balls;

void setup() {
  size(800, 800);
  ellipseMode(CENTER);
  background(0);
  balls = new ArrayList<Ball>();
  for (int i = 0; i < 50; i++) {
    balls.add(new Ball());
  }
  createBalls();
}

void draw() {
  background(0);
  createBalls();
}

void createBalls() {
  for (Ball b : balls) {
    b.move();
  }
}
