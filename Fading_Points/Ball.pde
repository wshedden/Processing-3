class Ball {
  PVector pos;
  PVector vel;
  float r = 7;
  public Ball() {
    reset();
  }

  void reset() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(random(-3, 3), random(-3, 3));
  }
  
  int getColour(){
     return lerpColor(color(217, 59, 164), color(62, 189, 170), pos.x*pos.y/width/height*2.5);
  }

  void display() {
    float dist = pos.dist(new PVector(mousePos.x, mousePos.y));
    int vis = max(min((int) (20000/dist), 255), 0);
    vis = vis > 100 ? vis : 0;
    strokeWeight(0.5);
    fill(getColour(), vis);
    stroke(200, vis);
    line(pos.x, pos.y, mousePos.x, mousePos.y);
    ellipse(pos.x, pos.y, 2*r, 2*r);
  }

  void bounce() {
    if (pos.x > width-r || pos.x < r || pos.y > height-r || pos.y < r) {
      reset();
    }
  }

  void move() {
    pos.add(vel);
  }

  void update() {
    move();
    bounce();
    display();
  }
}
