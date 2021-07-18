class Board {
  private House[][] houses;
  int turnCounter = 0;

  public Board() {
    houses = new House[2][];
    for (int i = 0; i < 2; i++) {
      houses[i] = new House[7];
      for (int j = 0; j < 6; j++) {
        houses[i][j] = new House(j*90, i*90, false);
      }
      houses[i][6] = new House(-90+630*i, 45, true);
    }
  }

  void show() {
    translate(380, 320);
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 7; j++) {
        houses[i][j].show();
      }
    }
  }
}
