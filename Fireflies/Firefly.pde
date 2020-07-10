class Firefly {
  PVector pos;
  PVector vel;
  int colour;
  float clock;
  float pulse = 0;

  public Firefly() {
    colour = color(20);
    pos = new PVector(random(width), random(height));
    vel = new PVector(random(-0.5, 0.5), random(-0.5, 0.5));
    clock = random(0, 1);
  }

  void display() {
    noStroke();
    fill(colour);
    ellipse(pos.x, pos.y, 15, 15);
  }

  void update() {
    clock += 0.001;
    pulse = max(pulse - 0.01, 0);
    vel.add(random(-0.2, 0.2), random(-0.2, 0.2));
    vel.limit(2);
    pos.add(vel);
    pos = new PVector(abs(pos.x+width) % width, abs(pos.y+height) % height);
    if(clock > 1){
       clock = 0;
       pulse = 1;
    }
    colour = lerpColor(color(20), color(252, 227, 3), pulse);
    display();
  }
}
