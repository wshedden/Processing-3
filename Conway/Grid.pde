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

  void tick() {
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

  void getNeighbours(int x, int y) {
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

  void birth(int x, int y) {
    cells[(int)((float)x/l)][(int)((float)y/l)].alive = true;
  }
  
  void birthBlock(int x, int y) {
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

  void kill(int x, int y) {
    cells[(int)((float)x/l)][(int)((float)y/l)].alive = false;
  }

  void display() {
    for (int i = 0; i < cells.length; i++) {
      for (int k = 0; k < cells[i].length; k++) {
        cells[i][k].display();
      }
    }
  }
}
