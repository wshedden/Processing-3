public class Person {
  float r;
  float x;
  float y;
  int colour = color(0, 200, 100);
  boolean infected = false;
  boolean dead = false;
  boolean immune = false;
  int deathTick;
  int decompositionTick;
  int lifespan;
  public Person(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    lifespan = (int) random(MAX_LIFESPAN/10, MAX_LIFESPAN);
  }

  void display() {
    fill(colour);
    ellipseMode(CORNER);
    rectMode(CORNER);
    stroke(0);
    strokeWeight(0.5);
    rect(x, y, r*2, r*2);
    //ellipse(x, y, r*2, r*2);
  }

  void runInfection(float deathRate) {
    if (tick-deathTick > lifespan) {
      if (random(0, 1) < deathRate) {
        dead = true;
        infected = false;
        immune = false;
        decompositionTick = 0;
      } else {
        infected = false;
        immune = true;
      }
    }
  }

  void getInfected() {
    if (!immune) {
      infected = true;
      deathTick = tick;
      immune = true;
    }
  }

  void update() {
    if (!dead) {
      if (!infected) {
        if (immune) colour = color(17, 142, 153);
        else colour = color(0, 200, 100);
      } else {
        colour = color(230, 18, 18);
        runInfection(DEATH_RATE);
      }
      display();
    } else {
      if (decompositionTick < DECOMPOSITION_TIME) {
        colour = color(50);
        decompositionTick++;
        display();
      }
    }
  }
}
