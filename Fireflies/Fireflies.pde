Firefly[] bugs;
int n = 500;
void setup() {
  size(1400, 800);
  bugs = new Firefly[n];
  for (int i = 0; i < n; i++) {
    bugs[i] = new Firefly();
  }
  ellipseMode(CENTER);
}

void draw() {
  frameRate(60);
  background(0);
  for (int i = 0; i < n; i++) {
    bugs[i].update(); 
    for (int k = 0; k < n; k++) {
      if (i != k) {
        if (bugs[i].pos.dist(bugs[k].pos) < 80) {
          if (bugs[k].clock == 0) {
            bugs[i].clock += 0.1;
          }
        }
      }
    }
  }
}
