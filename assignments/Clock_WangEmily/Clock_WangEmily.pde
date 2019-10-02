/*
* Assignment 3: Clock
* Emily Wang
* 6.19.19
*/

//global variables used by multiple functions, including draw()
PFont mono; //font
int h, min, s; //hour, minute, second
int x, y, w, l;
int start; //off-screen either to the right or to the left
boolean forward; //direction of movement
color c; //consistent hue across each frame
int speed; //speed of movement
ArrayList<Line> lines;

void setup() {
  size(1600, 800);
  background(0);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
  mono = createFont("BPmono.ttf", height/5);
  textFont(mono);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  
  //initializing global variables
  c = color(random(0, 360), random(20, 60), random(60, 80));
  start = -800;
  x = start;
  y = int(random(height/10, height * 9/10 + 0.5));
  w = 800;
  l = 160;
  h = civTime(hour());
  min = minute();
  s = second();
  speed = (s + 20) / 4;
  lines = new ArrayList<Line>();
  generateLines(start - 800, start + 800);
  drawLines();
  drawBox(c);
  forward = true; //initial direction is forward
}

void draw() {
  background(0);
  int d;
  //if box/lines are still moving across screen
  if (x <= width + 800 && x >= -800) {
    if (forward) {
      d = speed; //positive distance = move to the right (forward)
    } else {
      d = -speed; //negative distance = move to the left (backward)
    }
    //move x position of box and each line by the distance
    x += d;
    for (Line line : lines) {
        line.move(d);
        line.create();
    }
    drawBox(c);
  } else { //if box/lines are now offscreen
    start = width - start; //switches start point (offscreen left/right)
    forward = !forward; //switches direction (to the left/to the right)
    //reset global variables
    x = start;
    y = int(random(height/10, height * 9/10 + 0.5));
    c = color(random(0, 360), random(20, 60), random(60, 80));
    speed = (s + 20) / 4;
    generateLines(start - 800, start + 800);
    drawLines();
    drawBox(c);
  }
}

/**
* converts argument from military time to civilian time
* e.g. 13:00 -> 1:00
*/
int civTime(int h) {
  if (h == 0) {
    return 12;
  }
  else if (h <= 12) {
    return h;
  } else {
    return h - 12;
  }
}

/**
* draws 3 sides of a rectangular box and adds time as text
* uses global x, y, w, l variables for position, width, and length
*/
void drawBox(color col) {
  noStroke();
  h = civTime(hour());
  min = minute();
  s = second();
  fill(col);
  rect(x, y, w, l);
  col = color(hue(col), saturation(col), brightness(col) - 10);
  fill(col);
  //coordinates of the corners, used to draw the upper and right sides of the box
  int leftX = x - w/2;
  int topY = y - l/2;
  int rightX = x + w/2;
  int bottomY = y + l/2;
  quad(leftX, topY, rightX, topY, rightX + 20, topY - 20, leftX + 20, topY - 20);
  col = color(hue(col), saturation(col), brightness(col) - 20);
  quad(rightX, topY, rightX, bottomY, rightX + 20, bottomY - 20, rightX + 20, topY - 20);
  fill(#ffffff); //white text
  text(nf(h, 2) + ":" + nf(min, 2) + ":" + nf(s, 2), x, y - 20);
}

/**
* creates Line objects and adds them to the list,
*     but does not draw lines on the screen yet
*/
void generateLines(int s, int e) {
  lines.clear();
  color col = color(hue(c), saturation(c), brightness(c) + 40, opacity(hour()));
  for (int i = 0; i < height; i += height/(min + 1)) {
    lines.add(new Line(random(s, e), random(s, e), i, col));
  }
}

/**
* draws all Line objects in the lines list on the screen
*/
void drawLines() {
  for (Line line : lines) {
    line.create();
  }
}

/**
* returns high opacity for AM hours,
*    low opacity for PM hours
*/
int opacity(int h) {
  if (h <= 12) {
    return 80;
  } else {
    return 30;
  }
}

/**
* class used to define lines and control their movement
* attributes: start and end X position, y position, color
*/
class Line {
  float startX;
  float endX;
  float y;
  color col;
  
  Line(float x1, float x2, float y, color col) {
    startX = x1;
    endX = x2;
    this.y = y;
    this.col = col;
  }
  
  /**
  * shifts line by a certain distance (+ for right, - for left)
  */
  void move(int dist) {
    startX += dist;
    endX += dist;
  }
  
  void create() {
    stroke(col);
    strokeWeight(h);
    line(startX, y, endX, y);
  }
}
