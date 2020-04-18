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

public class DVD_logo extends PApplet {

float cubeSize = 80;
int cubeNum = 1;

ArrayList<Cube> cubes = new ArrayList<Cube>();

public void setup() {
  
  for (int i = 0; i < cubeNum; i++) {
    cubes.add(new Cube(cubeSize));
  }
}

public void draw() {
  background(0, 0, 127);
  for (int i = 0; i < cubes.size(); i++) {
    cubes.get(i).update();
  }
}

public void mousePressed() {
  if (mouseButton == LEFT) {
    cubes.add(new Cube(cubeSize));
    cubes.get(cubes.size()-1).pos.x = mouseX-cubeSize/2;
    cubes.get(cubes.size()-1).pos.y = mouseY-cubeSize/2;
  }
}
class Cube {
  PVector pos;
  PVector vel;
  int colour;
  int[] colours = new int[]{color(255, 0, 0), color(0, 255, 0), color(0, 0, 255)};

  float side;
  Cube(float side) {
    this.side = side;
    pos = new PVector(random(side, width-side), random(side, height-side));
    float velX = random(1, 3);
    float velY = random(1, 3);
    if (random(0, 1) < 0.5f) {
      velX *= -1;
    }
    if (random(0, 1) < 0.5f) {
      velY *= -1;
    }
    vel = new PVector(velX, velY);
    colour = colours[round(random(0, colours.length-1))];
  }

  public void move() {
    pos.add(vel); 
    vel.limit(3);
  }

  public void changeColour() {
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

  public void detectCollisions() {
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

  public void display() {
    fill(colour);
    strokeWeight(0);
    rect(pos.x, pos.y, side, side);
    fill(0);
    textSize(26);
    text("DVD", pos.x+side/8, pos.y+side/2);
    textSize(13);
    text("VIDEO", pos.x+side*0.23f, pos.y+side*0.8f);
  }

  public void update() {
    move();
    detectCollisions();
    display();
  }
}
  public void settings() {  size(1000, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DVD_logo" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
