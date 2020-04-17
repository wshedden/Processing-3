ArrayList<Circle> circles = new ArrayList<Circle>();
boolean circleMode = false;
int keyDelay = 0;

void setup() {
  size(1000, 1000);
  circles.add(new Circle(0, 0, width/2));
  ellipseMode(CORNER);
}

void draw() {
  background(33, 176, 171);
  keyDelay--;
  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).display();
    if (circles.get(i).isClicked()) {
      circles.addAll(circles.get(i).split());
      circles.remove(i);
    }
  }
  println(circles.size());
}

void keyPressed() {
  if (key == ' ' && keyDelay < 1) 
    circleMode = !circleMode;
  keyDelay = 10;
}
