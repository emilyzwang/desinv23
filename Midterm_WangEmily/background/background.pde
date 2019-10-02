/*
* dark night sky
*/

color c;

void setup() {
  size(1600, 1600);
  colorMode(HSB, 360, 100, 100);
  c = color(200, 100, 1);
  drawBackground();
  save("skyline.png");
}

void draw() {
  
}

void drawBackground() {
  for (int i = 0; i <= height; i++) {
    stroke(c);
    line(0, i, width, i);
    if (i % 10 == 0) {
      c = color(hue(c), saturation(c), brightness(c));
    }
  }
}

void drawStars() {
  
}
