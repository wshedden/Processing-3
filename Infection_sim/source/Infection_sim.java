import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Infection_sim extends PApplet {

final public float INFECTION_RATE = 0.01f;
final public float DEATH_RATE = 0.08f;
final public float GLOBAL_TRANSMISSION = 0.0005f;
final public int MAX_LIFESPAN = 100;
final public int DECOMPOSITION_TIME = 50;

final int l = 15;

public boolean placeMode = false;
public int tick;
Population population;

public void setup() {
  
  population = new Population(l, width, height);
}

public void draw() {
  frameRate(60);
  tick++;
  background(50);
  population.update();
}

public void mousePressed() {
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

public void mouseDragged(){
  if(placeMode){
    if (mouseButton == LEFT) {
      population.setImmune(mouseX, mouseY);
    } else if (mouseButton == RIGHT){
      population.setInfected(mouseX, mouseY);
    }
  }
}

public void keyPressed() {
  if(keyCode == 32){
    placeMode = !placeMode;
  }
}
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

  public void display() {
    fill(colour);
    ellipseMode(CORNER);
    rectMode(CORNER);
    stroke(0);
    strokeWeight(0.5f);
    rect(x, y, r*2, r*2);
    //ellipse(x, y, r*2, r*2);
  }

  public void runInfection(float deathRate) {
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

  public void getInfected() {
    if (!immune) {
      infected = true;
      deathTick = tick;
      immune = true;
    }
  }

  public void update() {
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
public class Population {
  int l;
  public int nX;
  public int nY;
  Person[][] population;
  int[][] neighbours = new int[][]{new int[]{-1, -1}, new int[]{-1, 0}, new int[]{-1, 1}, new int[]{0, -1}, new int[]{0, 1}, new int[]{1, -1}, new int[]{1, 0}, new int[]{1, 1}};
  //int[][] neighbours = new int[][]{new int[]{-1, 0}, new int[]{0, -1}, new int[]{0, 1},new int[]{1, 0}}; //Only adjacent neighbours infected

  public Population(int l, int w, int h) {
    this.l = l;
    nX = w/l;
    nY = h/l;
    population = new Person[nX][];
    for (int i = 0; i < nX; i++) {
      population[i] = new Person[nY];
      for (int k = 0; k < nY; k++) {
        population[i][k] = new Person(i*l, k*l, l/2);
      }
    }
  }

  public void update() {
    for (int i = 0; i < nX; i++) {
      for (int k = 0; k < nY; k++) {
        population[i][k].update();
      }
    }
    propagate(INFECTION_RATE);
  }

  public void infectRandom() {
    int x = (int) random(0, nX);
    int y = (int) random(0, nY);
    population[x][y].getInfected();
  }

  public void setImmune(int x, int y){
    x /= l;
    y /= l;
    population[(int) x][(int) y].immune = true;
  }

  public void setInfected(int x, int y){
    x /= l;
    y /= l;
    population[(int) x][(int) y].immune = false;
    population[(int) x][(int) y].getInfected();
  }

  public void propagate(float infectionRate) {
    for (int i = 0; i < nX; i++) {
      for (int k = 0; k < nY; k++) {
        if (population[i][k].infected) {
          for (int n = 0; n < neighbours.length; n++) {
            try {
              if (random(0, 1) < infectionRate) {
                if (random(0, 1) < GLOBAL_TRANSMISSION) {
                  infectRandom();
                } else {
                  Person p = population[i+neighbours[n][0]][k+neighbours[n][1]];
                  if (!p.infected && !p.dead && !p.immune) {
                    population[i+neighbours[n][0]][k+neighbours[n][1]].getInfected();
                  }
                }
              }
            }
            catch(Exception e) {
            }
          }
        }
      }
    }
  }
}
  public void settings() {  size(1200, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Infection_sim" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
