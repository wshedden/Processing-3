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

  void update() {
    for (int i = 0; i < nX; i++) {
      for (int k = 0; k < nY; k++) {
        population[i][k].update();
      }
    }
    propagate(INFECTION_RATE);
  }

  void infectRandom() {
    int x = (int) random(0, nX);
    int y = (int) random(0, nY);
    population[x][y].getInfected();
  }

  void setImmune(int x, int y){
    x /= l;
    y /= l;
    population[(int) x][(int) y].immune = true;
  }

  void setInfected(int x, int y){
    x /= l;
    y /= l;
    population[(int) x][(int) y].immune = false;
    population[(int) x][(int) y].getInfected();
  }

  void propagate(float infectionRate) {
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
