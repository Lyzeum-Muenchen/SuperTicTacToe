//import java.util.Arrays;

class Game {
  SimpleBoard board;
  int currentPlayer = 1; // 1 oder 2
  final int DEPTH;
  int[][] active;
  boolean firstTurn = true;
  Player[] players = new Player[2];
  boolean ready = true;
  
  private Game (Game copy){
    board = copy.board.copy(this);
    currentPlayer = copy.currentPlayer;
    DEPTH = copy.DEPTH;
    active = new int[DEPTH+1][2];
    for (int i = 0; i < DEPTH + 1; i++){
      active[i][0] = copy.active[i][0];
      active[i][1] = copy.active[i][1];
    }
    firstTurn = copy.firstTurn; 
    players = new Player[2];
  }

  Game (int DEPTH, int x, int y, int size) {
    this.DEPTH = DEPTH;
    active = new int[DEPTH+1][2];
    if (DEPTH == 0) {
      board = new SimpleBoard(this, x, y, size);
    } else {
      board = new SuperBoard(this, x, y, size, DEPTH);
    }
    players[0] = new Montecarlo(this, 0);
    players[1] = new Montecarlo(this, 1);
    
  }

  void draw() {
    if (firstTurn) board.highlight();
    board.draw(true);
    if (ready) {
      ready = false;
      players[currentPlayer-1].makeMove();
    }
  }

  void mousePressed() {
    if (mouseX >= board.x && mouseY >= board.y && mouseX < board.x + board.size && mouseY < board.y + board.size) {
      players[0].mousePressed();
      players[1].mousePressed();
    }
  }
  
  void nextTurn() {
    firstTurn = false;
    currentPlayer = 3 - currentPlayer;
    if (board.winner == 0){
      //println(Arrays.deepToString(board.fields));
      ready = true;
    }
    
  }
  
  void run() {
    nextTurn();
    while(board.winner == 0){
      players[currentPlayer-1].makeMove();
    }
  }
  
  Game copy(){
    return new Game(this);
  }
  
}
