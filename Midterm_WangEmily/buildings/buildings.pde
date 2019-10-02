/*
* testing P3D sketching
*/

import spout.*;

Spout spout;
PGraphics pgr;

ArrayList<Window> windows;

void setup() {
  size(800, 800, P3D);
  background(0);
  fill(#FFFFB2);
  rectMode(CENTER);
  
  windows = new ArrayList();
  
  pgr = createGraphics(1280, 720, P3D);
  
  spout = new Spout(this);
  spout.createSender("Spout Processing");
  
  drawBuilding();
}

void draw() {
  background(0);
  for (Window w : windows) {
    w.display();
  }
  
  spout.sendTexture();
}

void drawBuilding() {
  for (int i = 40; i <= width - 40; i += 60) {
    for (int j = 40; j <= height - 80; j += 60) {
      windows.add(new Window(new PVector(i, j)));
    }
  }  
}
