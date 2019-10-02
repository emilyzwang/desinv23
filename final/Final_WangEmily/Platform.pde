class Platform {
  float position;
  int size;
  
  Platform() {
    position = 0;
    size = 500;
  }
  
  void update(float pos) {
    position = pos;
  }
  
  void display() {
    fill(0);
  }
}
