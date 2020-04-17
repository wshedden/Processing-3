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
  
  void display() {
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
