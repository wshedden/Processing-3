void botMove(char[][] board, char player) {
  Result result = minimax(board, player, turn);
  int[] play = result.move;
  move(board, player, play[0], play[1]);
}
class Result {
  int score;
  int[] move;
  Result(int score, int[] move) {
    this.score = score;
    this.move = move;
  }
}

Result minimax(char[][] board, char player, int turn) {
  char winner = getWinner(board, turn);
  char player2 = player == 'X' ? 'O' : 'X';

  if (winner == player) {
    return new Result(1, new int[0]) ;
  } else if (winner == 'D') {
    return new Result(0, new int[0]) ;
  } else if (winner == player2) {
    return new Result(-1, new int[0]) ;
  }

  ArrayList<int[]> moves = new ArrayList<int[]>();
  ArrayList<Integer> scores = new ArrayList<Integer>();
  for (int i = 0; i < 3; i++) {
    for (int k = 0; k < 3; k++) {
      if (isLegal(board, i, k)) {
        char[][] newBoard = new char[3][3];
        for (int x = 0; x < 3; x++) {
          for (int y = 0; y < 3; y++) {
            newBoard[x][y] = board[x][y];
          }
        }
        moves.add(new int[]{i, k});
        move(newBoard, player, i, k);
        scores.add(minimax(newBoard, player2, turn+1).score);
      }
    }
  }

  int minscore = 100;
  ArrayList<int[]> minmoves = new ArrayList<int[]>();
  for (int i = 0; i < moves.size(); i++) {
    if (scores.get(i) == minscore) {
      minmoves.add(moves.get(i));
    }
    if (scores.get(i) < minscore) {
      minscore = scores.get(i);
      minmoves.clear();
      minmoves.add(moves.get(i));
    }
  }
  int[] minmove = minmoves.get((int) random(minmoves.size()));
  return new Result(-minscore, minmove);
}
