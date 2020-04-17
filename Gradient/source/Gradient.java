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

public class Gradient extends PApplet {

ArrayList<Circle> circles = new ArrayList<Circle>();
boolean circleMode = false;
int keyDelay = 0;

public void setup() {
  
  circles.add(new Circle(0, 0, width/2));
  ellipseMode(CORNER);
}

public void draw() {
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

public void keyPressed() {
  if (key == ' ' && keyDelay < 1) 
    circleMode = !circleMode;
  keyDelay = 10;
}
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

  public void display() {
    fill(colour);
    stroke(colour);
    if (circleMode)
      ellipse(x, y, r*2, r*2);
    else rect(x, y, r*2, r*2);
  }

  public void setColour() {
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
  public void settings() {  size(1000, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Gradient" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
