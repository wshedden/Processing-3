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
  frameRate(10000);
  background(0);
  for (int i = 0; i < n; i++) {
    bugs[i].update(); 
    for (int k = 0; k < n; k++) {
      if (i != k) {
        if (bugs[i].pos.dist(bugs[k].pos) < 80) {
          //stroke(255);
          //line(bugs[i].pos.x, bugs[i].pos.y, bugs[k].pos.x, bugs[k].pos.y);
          if (bugs[k].pulse == 1) {
            println("zing");
            //bugs[i].pulse = (bugs[i].pulse+1f)/2f;
            bugs[i].clock += 0.05;
          }
        }
      }
    }
  }
}
