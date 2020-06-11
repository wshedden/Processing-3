Chain chain;
ArrayList<PVector> dots = new ArrayList<PVector>();
int children = 1;

void setup() {
  size(1200, 800, P3D);
  chain = new Chain(0, 0.03, 80, 0);
  chain.createChildren(children);
}


void draw() {
  push();
  translate(width/2, height/2);
  background(0);
  chain.orbit();
  chain.show();
  pop();
  for (int i = 0; i < dots.size()-1; i++) {
    strokeWeight(4);
    PVector dot1 = dots.get(i);
    PVector dot2 = dots.get(i+1);
    stroke(255);
    line(dot1.x, dot1.y, dot2.x, dot2.y);

  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    children++;
  } else if (mouseButton == RIGHT && children > 0) {
    children--;
  }
  setup();
  dots.clear();
}
