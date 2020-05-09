char[][] board = new char[3][3];
int turn = 1;
float x, y, l, x_off, o_off, y_off;
PImage space;

void setup() {
  size(800, 600);
  space = loadImage("space.jpg");
  resetBoard(board);
  l = 400;
  x = width/2-l/2;
  y = height/2-l/2;
  x_off = 0.06*l;
  o_off = 0.04*l;
  y_off = -0.04*l;
}

void draw() {
  background(0);
  image(space, 0, 0);
  display(board, x, y, l);
  char winner = getWinner(board, turn);
  String msg = "";
  if (winner == 'X') {
    msg = "Player wins";
  } else if (winner == 'O') {
    msg = "AI wins";
  } else if (winner == 'D') {
    msg = "It's a draw";
  }
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text(msg, width/2, height-40);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (getWinner(board, turn) == 'N') {
      boolean success = false;
      if (turn <= 9) {
        success = playerMove(board, x, y, l);
        if (success) turn++;
      }
      if (turn <= 9 && success) {
        botMove(board, 'O');
        turn++;
      }
    }
  } else if (mouseButton == RIGHT) {
    resetBoard(board);
    turn = 1;
  }
}
