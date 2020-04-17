class Circle {
  float x;
  float y;
  float r;
  int colour;
  public Circle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    setColour();
  }

  void display() {
    fill(colour);
    stroke(colour);
    if (circleMode)
      ellipse(x, y, r*2, r*2);
    else rect(x, y, r*2, r*2);
  }

  void setColour() {
    colour = color(255*x/width, 20+80*y/height, 20+255*y/height);
  }

  public boolean isClicked() {
    return r > 1 && mousePressed && mouseButton == LEFT && dist(x+r, y+r, mouseX, mouseY) < r;
  }

  public ArrayList<Circle> split() {
    ArrayList<Circle> circles = new ArrayList<Circle>();
    circles.add(new Circle(x, y, r/2));
    circles.add(new Circle(x+r, y, r/2));
    circles.add(new Circle(x, y+r, r/2));
    circles.add(new Circle(x+r, y+r, r/2));
    return circles;
  }
}
