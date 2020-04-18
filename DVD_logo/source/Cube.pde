class Cube {
  PVector pos;
  PVector vel;
  color colour;
  color[] colours = new color[]{color(255, 0, 0), color(0, 255, 0), color(0, 0, 255)};

  float side;
  Cube(float side) {
    this.side = side;
    pos = new PVector(random(side, width-side), random(side, height-side));
    float velX = random(1, 3);
    float velY = random(1, 3);
    if (random(0, 1) < 0.5) {
      velX *= -1;
    }
    if (random(0, 1) < 0.5) {
      velY *= -1;
    }
    vel = new PVector(velX, velY);
    colour = colours[round(random(0, colours.length-1))];
  }

  void move() {
    pos.add(vel); 
    vel.limit(3);
  }

  void changeColour() {
    for (int i = 0; i < colours.length; i++) {
      if (colour == colours[i]) {
        if (i != colours.length-1) {
          colour = colours[i+1];
        } else {
          colour = colours[0];
        }
        break;
      }
    }
  }

  void detectCollisions() {
    if (pos.x < 0) {
      vel.x *= -1;
      pos.x = 1;
      changeColour();
    }
    if (pos.x > width-side) {
      vel.x *= -1;
      pos.x = width-side-1;
      changeColour();
    }
    if (pos.y < 0) {
      vel.y *= -1;
      pos.y = 1;
      changeColour();
    }
    if (pos.y > height-side) {
      vel.y *= -1;
      pos.y = height-side-1;
      changeColour();
    }
  }  

  void display() {
    fill(colour);
    strokeWeight(0);
    rect(pos.x, pos.y, side, side);
    fill(0);
    textSize(26);
    text("DVD", pos.x+side/8, pos.y+side/2);
    textSize(13);
    text("VIDEO", pos.x+side*0.23, pos.y+side*0.8);
  }

  void update() {
    move();
    detectCollisions();
    display();
  }
}
