class Window {
  int w, h;
  PVector location;
  boolean on;
  long startTime;
  float wait;
  
  Window(PVector loc) {
    w = 40;
    h = 40;
    location = loc;
    on = false;
    wait = random(10000, 20000);
  }
  
  void display() {
    PVector mouse = new PVector(mouseX, mouseY);
    if (on) {
      rect(location.x, location.y, w, h);
      if (startTime + wait <= millis()) {
        on = false;
      } 
    } else if (PVector.sub(location, mouse).mag() <= 20) {
      on = true;
      startTime = millis();
    }
  }  
}
