Grid grid;
public boolean pause = false;
public final int[][] NEIGHBOURS = new int[][]{new int[]{-1, -1}, new int[]{-1, 0}, new int[]{-1, 1}, new int[]{0, -1}, new int[]{0, 1}, new int[]{1, -1}, new int[]{1, 0}, new int[]{1, 1}};
final float l = 25;
int tick = 0;
int interval = 10;

void setup() {
  size(1200, 800);
  grid = new Grid(l);
}

void draw() {
  tick++;
  if (tick % interval == 0) {
    if (!pause) {
      grid.tick();
    }
  }
  grid.display();
}

void mouseDragged() {
  if (mouseX > l && mouseY > l && mouseX < width-l && mouseY < height-l) {
    if (mouseButton == LEFT) {
      grid.birth(mouseX, mouseY);
      //grid.birthBlock(mouseX, mouseY);
    } else if (mouseButton == RIGHT)
      grid.kill(mouseX, mouseY);
  }
}

void mousePressed() {
  mouseDragged();
}

void keyReleased() {
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

void keyPressed() {
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
