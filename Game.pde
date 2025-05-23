class Game {
  SimpleBoard board;
  int currentPlayer = 1; // 1 oder 2
  final int DEPTH;
  int[][] active;
  boolean firstTurn = true;
  Player[] players = new Player[2];

  Game(int DEPTH, int x, int y, int size) {
    this.DEPTH = DEPTH;
    active = new int[DEPTH+1][2];
    if (DEPTH == 0) {
      board = new SimpleBoard(this, x, y, size);
    } else {
      board = new SuperBoard(this, x, y, size, DEPTH);
    }
    players[0] = new RandomBot(this);
    players[1] = new RandomBot(this);
    
    players[0].makeMove();
  }
  
  void draw() {
    board.draw(! firstTurn);
  }
  
  
  void mousePressed() {
    if (mouseX >= board.x && mouseY >= board.y && mouseX < board.x + board.size && mouseY < board.y + board.size) {
      players[currentPlayer-1].mousePressed();
    }
  }
  
  void nextTurn() {
    if (board.winner == 0){
      currentPlayer = 3 - currentPlayer;
      firstTurn = false;
      players[currentPlayer - 1].makeMove();
    }
  }
  
  
}
