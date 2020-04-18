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

public class Fractals extends PApplet {

Tree tree;
boolean forwards = true;
int i = 0;
int smoothness = 100;
float globalMult = 0.66667f;

public void setup(){
  
  tree = new Tree(TWO_PI*0.8f);
  
}


public void draw(){
  if(i == 0 || i == smoothness) forwards = !forwards;
  if(forwards) i++;
  else i--;
  background(0);
  tree = new Tree(0.5f*TWO_PI*i/smoothness);
  translate(width/2, height);
  tree.branch(260, globalMult);
}


public void mousePressed(){
   switch(mouseButton){
      case LEFT: globalMult += 0.01f; return;
      case RIGHT: globalMult -= 0.01f; return;
      default: return;
     
   }
  
}
class Tree {
  float theta;
  
  Tree(float theta) {
    this.theta = theta;
  }
  
  public void branch(float len, float lenMultiplier){
    strokeWeight(2);
    stroke(100, 10, 130);
    line(0, 0, 0, -len);
    
    translate(0, -len);
    len *= lenMultiplier;
    
    if(len > 2){
       pushMatrix();
       rotate(theta);
       branch(len, lenMultiplier); 
       popMatrix();
       
       pushMatrix();
       rotate(-theta);
       branch(len, lenMultiplier);
       popMatrix();
    }
  }
}
  public void settings() {  size(1200, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Fractals" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
