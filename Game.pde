class Game {
  SimpleBoard board;
  int currentPlayer = 1; // 1 oder 2
  final int DEPTH;
  int[][] active;
  boolean firstTurn = true;
  Player[] players = new Player[2];
  boolean ready = true;

  Game(int DEPTH, int x, int y, int size) {
    this.DEPTH = DEPTH;
    active = new int[DEPTH+1][2];
    if (DEPTH == 0) {
      board = new SimpleBoard(this, x, y, size);
    } else {
      board = new SuperBoard(this, x, y, size, DEPTH);
    }
    players[0] = new MonteCarloBot(this);
    players[1] = new MonteCarloBot(this);
    
    players[0].makeMove();
  }
  
  private Game(int DEPTH) {
    this.DEPTH = DEPTH;
  }
  
  void draw() {
    board.draw(! firstTurn);
    if (ready) {
      //println("Winner: " + board.winner);
      //int[] wins = new int[2];
      //for (int i = 0; i < 100000; i++){
      //  Game copy = this.copy();
      //  copy.players[0] = new RandomBot(copy);
      //  copy.players[1] = new RandomBot(copy);
      //  copy.run();
      //  if (copy.board.winner == 1) wins[0] ++;
      //  if (copy.board.winner == 2) wins[1] ++;
      //}
      //println (wins[0] + " : " + wins[1]);
      
      
      ready = false;
      players[currentPlayer - 1].makeMove();
    }
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
      ready = true;
    }
  }
  
  Game copy () {
    Game copy = new Game(DEPTH);
    copy.board = board.copy(copy);
    copy.currentPlayer = currentPlayer;
    copy.firstTurn = firstTurn;
    copy.players = new Player[2];
    copy.active = new int[DEPTH+1][2];
    for (int i = 0; i < DEPTH + 1; i ++){
      copy.active[i][0] = active[i][0];
      copy.active[i][1] = active[i][1];
    }
    return copy;
  }
  
  void run () {
    while (board.winner == 0){
      players[currentPlayer - 1].makeMove();
    }
  }
  
  
}
