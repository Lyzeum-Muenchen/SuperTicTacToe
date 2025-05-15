class Game {
  SimpleBoard board;
  int currentPlayer = 1; // 1 oder 2
  final int DEPTH;
  int[][] active;
  boolean firstTurn = true;

  Game (int DEPTH, int x, int y, int size) {
    this.DEPTH = DEPTH;
    active = new int[DEPTH+1][2];
    if (DEPTH == 0) {
      board = new SimpleBoard(this, x, y, size);
    } else {
      board = new SuperBoard(this, x, y, size, DEPTH);
    }
  }

  void draw() {
    if (firstTurn) board.highlight();
    board.draw(true);
  }

  void mousePressed() {
    if (mouseX >= board.x && mouseY >= board.y && mouseX < board.x + board.size && mouseY < board.y + board.size) {
      if (board.mousePressed()) {
        currentPlayer = 3 - currentPlayer;
        firstTurn = false;
      }
    }
  }
}
