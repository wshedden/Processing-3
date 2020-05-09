void display(char[][] board, float x, float y, float l) {
  fill(0);
  noStroke();
  rectMode(CORNER);
  rect(x, y, l, l, 15);
  fill(255);
  stroke(255);
  strokeWeight(3);
  textSize(l/3);
  textAlign(LEFT);
  line(x+l/3, y, x+l/3, y+l);
  line(x+2*l/3, y, x+2*l/3, y+l);
  line(x, y+l/3, x+l, y+l/3);
  line(x, y+2*l/3, x+l, y+2*l/3);
  for (int i = 0; i < 3; i++) {
    for (int k = 1; k < 4; k++) {
      float off = board[i][k-1] == 'X' ? x_off : o_off;
      text(board[i][k-1], x+i*l/3+off, y+k*l/3+y_off);
    }
  }
}

boolean playerMove(char[][] board, float x, float y, float l) {
  for (int i = 0; i < 3; i++) {
    for (int k = 0; k < 3; k++) {
      if (mouseX > x+i*l/3 && mouseX < x+(i+1)*l/3) {
        if (mouseY > y+k*l/3 && mouseY < y+(k+1)*l/3) {
          if (isLegal(board, i, k)) {
            move(board, 'X', i, k);
            return true;
          }
        }
      }
    }
  }
  return false;
}

boolean isLegal(char[][] board, int x, int y) {
  if (board[x][y] == ' ')
    return true;
  return false;
}

void move(char[][] board, char player, int x, int y) {
  if (board[x][y] != ' ') throw new Error();
  board[x][y] = player;
}

char getWinner(char[][] board, int turn) {
  for (int i = 0; i < 3; i++) {
    if (board[i][0] == board[i][1] && board[i][1] == board[i][2])
      if (board[i][0] != ' ') return board[i][0];
  }
  for (int k = 0; k < 3; k++) {
    if (board[0][k] == board[1][k] && board[1][k] == board[2][k])
      if (board[0][k] != ' ') return board[0][k];
  }
  if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != ' ') return board[0][0];
  if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][0] != ' ') return board[0][2];
  if (turn > 9) return 'D';
  return 'N';
}

void resetBoard(char[][] board) {
  for (int i = 0; i < 3; i++) {
    for (int k = 0; k < 3; k++) {
      board[i][k] = ' ';
    }
  }
}
