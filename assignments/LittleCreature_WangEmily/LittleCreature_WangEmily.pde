/*
* Assignment 4: Little Creatures
* Emily Wang
* 6.24.19
*/

ArrayList<Flower> flowers;
ArrayList<Bee> bees;
ArrayList<Bee> deadBees;
long wait;
long startTime;

void setup() {
  size(800, 800);
  ellipseMode(CENTER);
  colorMode(HSB, 360, 100, 100, 100);
  //light green background to imitate grass
  background(#3A8339);
  flowers = new ArrayList<Flower>();
  bees = new ArrayList<Bee>();
  deadBees = new ArrayList<Bee>();
  //Bee b = new Bee(new PVector(width/2, height/2), new PVector(-2, -2), 50);
  //b.display();
  startTime = millis();
  wait = 5000;
}

void draw() {
  //resets background to hide bees' paths
  background(#95C694);
  for (Flower f : flowers) {
    f.display();
  }
  //bees stay attracted to a flower for 5 seconds before moving to another flower
  if (millis() > startTime + wait) {
    for (Bee b : bees) {
      b.moveTo(flowers.get(int(random(flowers.size()))));
    }
    startTime = millis();
  }
  for (Bee b : deadBees) {
    if (bees.contains(b)) {
      bees.remove(b);
    }
    b.flyAway();
    b.display();
  }
  for (Bee b : bees) {
    b.move();
    b.display();
  }
}

void mouseClicked() {
  Flower f = new Flower();
  flowers.add(f);
  //each new flower attracts [2, 5) new bees to fly in
  float numBees = random(2, 5);
  for (int i = 0; i < numBees; i++) {
    //limits total number of bees to at most 20
    if (bees.size() >= 20) {
      break;
    } else {
      Bee b = new Bee();
      bees.add(b);
      b.moveTo(flowers.get(int(random(flowers.size())))); //random initial flower that bee is attracted to
    }
  }
}

//to save a screen capture (putting save() in draw() slowed it down too much)
void mouseDragged() {
  save("LittleCreature_WangEmily.png");
}
