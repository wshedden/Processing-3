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

public class Noughts_and_crosses extends PApplet {

char[][] board = new char[3][3];
int turn = 1;
float x, y, l, x_off, o_off, y_off;
PImage space;

public void setup() {
  
  space = loadImage("space.jpg");
  resetBoard(board);
  l = 400;
  x = width/2-l/2;
  y = height/2-l/2;
  x_off = 0.06f*l;
  o_off = 0.04f*l;
  y_off = -0.04f*l;
}

public void draw() {
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

public void mousePressed() {
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

public void display(char[][] board, float x, float y, float l) {
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

public boolean playerMove(char[][] board, float x, float y, float l) {
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

public boolean isLegal(char[][] board, int x, int y) {
  if (board[x][y] == ' ')
    return true;
  return false;
}

public void move(char[][] board, char player, int x, int y) {
  if (board[x][y] != ' ') throw new Error();
  board[x][y] = player;
}

public char getWinner(char[][] board, int turn) {
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

public void resetBoard(char[][] board) {
  for (int i = 0; i < 3; i++) {
    for (int k = 0; k < 3; k++) {
      board[i][k] = ' ';
    }
  }
}

public void botMove(char[][] board, char player) {
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

public Result minimax(char[][] board, char player, int turn) {
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

  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Noughts_and_crosses" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
