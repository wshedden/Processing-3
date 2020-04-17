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

public class Conway extends PApplet {

Grid grid;
public boolean pause = false;
public final int[][] NEIGHBOURS = new int[][]{new int[]{-1, -1}, new int[]{-1, 0}, new int[]{-1, 1}, new int[]{0, -1}, new int[]{0, 1}, new int[]{1, -1}, new int[]{1, 0}, new int[]{1, 1}};
final float l = 25;
int tick = 0;
int interval = 10;

public void setup() {
  
  grid = new Grid(l);
}

public void draw() {
  tick++;
  if (tick % interval == 0) {
    if (!pause) {
      grid.tick();
    }
  }
  grid.display();
}

public void mouseDragged() {
  if (mouseX > l && mouseY > l && mouseX < width-l && mouseY < height-l) {
    if (mouseButton == LEFT) {
      grid.birth(mouseX, mouseY);
      //grid.birthBlock(mouseX, mouseY);
    } else if (mouseButton == RIGHT)
      grid.kill(mouseX, mouseY);
  }
}

public void mousePressed() {
  mouseDragged();
}

public void keyReleased() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      tick++;
      grid.tick();
    }
  } else {
    if (key == ' ') {
      pause = !pause;
    }
  }
}

public void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && interval < 100) {
      interval++;
    } else if (keyCode == DOWN && interval > 1) {
      interval--;
    }
  } else {
    if(key == 'r') {
      grid = new Grid(l);
    }
  }
}
class Cell {
  float x;
  float y;
  float l;
  int n;
  boolean alive = false;
  
  public Cell(float x, float y, float l) {
    this.x = x;
    this.y = y;
    this.l = l;
  }
  
  public void display() {
    noStroke();
    //stroke(255);
    if (alive) {
      fill(255);
      stroke(180, 20, 255);
      strokeWeight(1);
    } else fill(0);
    rectMode(CORNER);
    rect(x, y, l, l);
  }
}
class Grid {
  float l;
  Cell[][] cells;

  public Grid(float l) {
    this.l = l;
    int nX = (int) (width/l);
    int nY = (int) (height/l);
    cells = new Cell[nX][nY];
    for (int i = 0; i < nX; i++) {
      for (int k = 0; k < nY; k++) {
        cells[i][k] = new Cell(i*l, k*l, l);
      }
    }
  }

  public void tick() {
    for (int i = 0; i < cells.length; i++) {
      for (int k = 0; k < cells[i].length; k++) {
        getNeighbours(i, k);
      }
    }
    for (int i = 0; i < cells.length; i++) {
      for (int k = 0; k < cells[i].length; k++) {
        int n = cells[i][k].n;
        if (cells[i][k].alive) {
          if (n < 2 || n > 3) {
            cells[i][k].alive = false;
          }
        } else {
          if (n == 3) {
            cells[i][k].alive = true;
          }
        }
      }
    }
  }

  public void getNeighbours(int x, int y) {
    int n = 0;
    for (int i = 0; i < NEIGHBOURS.length; i++) {
      try {
        if (cells[x+NEIGHBOURS[i][0]][y+NEIGHBOURS[i][1]].alive) {
          n++;
        }
      } 
      catch(Exception e) {
      }
    }
    cells[x][y].n = n;
  }

  public void birth(int x, int y) {
    cells[(int)((float)x/l)][(int)((float)y/l)].alive = true;
  }
  
  public void birthBlock(int x, int y) {
    x = (int)((float)x/l);
    y = (int)((float)y/l);
    cells[x][y].alive = true;
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        for (int k = 0; k < NEIGHBOURS.length; k++) {
          cells[x+NEIGHBOURS[k][0]][y+NEIGHBOURS[k][1]].alive = true;
        }
      }
    }
  }

  public void kill(int x, int y) {
    cells[(int)((float)x/l)][(int)((float)y/l)].alive = false;
  }

  public void display() {
    for (int i = 0; i < cells.length; i++) {
      for (int k = 0; k < cells[i].length; k++) {
        cells[i][k].display();
      }
    }
  }
}
  public void settings() {  size(1200, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Conway" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
