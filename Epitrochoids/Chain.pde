class Chain {
  float theta;
  float orbitSpeed;
  float radius;
  float distance;
  Chain child;
  color colour = color(155, 51, 214);

  Chain(float theta, float orbitSpeed, float radius, float distance) {
    this.theta = theta;
    this.orbitSpeed = orbitSpeed;
    this.radius = radius;
    this.distance = distance;
  }

  void orbit() {
    theta += orbitSpeed;
    if (child != null) {
      child.orbit();
    }
  }



  void createChildren(int n) {
    float t = 0;
    float v = orbitSpeed*2;
    float r = radius*2/3;
    float d = radius+r;
    if (random(0, 1) < 0.5) {
      //v *= -1;
    }

    child = new Chain(t, v, r, d);
    if (n > 1) {
      child.createChildren(n-1);
    }
  }


  void show() {
    push();
    rotate(theta);
    translate(distance, 0);
    fill(colour, radius*0.8);
    stroke(0, 50);
    strokeWeight(2);
    ellipse(0, 0, radius*2, radius*2);
    if (child == null) {
      dots.add(new PVector(modelX(0, 0, 0), modelY(0, 0, 0)));
    } else {
      child.show();
    }
    pop();
  }
}
