class House {
  private int value;
  private float x, y;
  private boolean isMancala;

  public House(float x, float y, boolean isMancala) {
    this.x = x;
    this.y = y;
    this.isMancala = isMancala;

    if (isMancala) {
      value = 0;
    } else {
      value = 4;
    }
  }

  public void show() {
    ellipseMode(CENTER);
    textSize(32);
    if (isMancala) {
      ellipse(x, y, 70, 130);
    } else {
      ellipse(x, y, 70, 70);
    }
    text(Integer.toString(value), x, y);
    println(Integer.toString(value);
  }
}
