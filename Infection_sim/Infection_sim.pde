final public float INFECTION_RATE = 0.01;
final public float DEATH_RATE = 0.08;
final public float GLOBAL_TRANSMISSION = 0.0005;
final public int MAX_LIFESPAN = 100;
final public int DECOMPOSITION_TIME = 50;

final int l = 15;

public boolean placeMode = false;
public int tick;
Population population;

void setup() {
  size(1200, 800);
  population = new Population(l, width, height);
}

void draw() {
  frameRate(60);
  tick++;
  background(50);
  population.update();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if(placeMode){
      population.setImmune(mouseX, mouseY);
    } else{
      population.infectRandom();
    }
  } else if (mouseButton == RIGHT && !placeMode) {
    population = new Population(l, width, height);
  }
}

void mouseDragged(){
  if(placeMode){
    if (mouseButton == LEFT) {
      population.setImmune(mouseX, mouseY);
    } else if (mouseButton == RIGHT){
      population.setInfected(mouseX, mouseY);
    }
  }
}

void keyPressed() {
  if(keyCode == 32){
    placeMode = !placeMode;
  }
}
