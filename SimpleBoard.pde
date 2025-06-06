class SimpleBoard {
  int x, y;
  int size;
  int[][] fields;
  int winner; // 1 oder 2, falls Sieger feststeht
  Game game;

  SimpleBoard (Game game, int x, int y, int size) {
    this.game = game;
    this.size = size;
    this.x = x;
    this.y = y;
    fields = new int[3][3];
    winner = 0;
  }
  
  void draw(boolean isActive) {
    if (isActive) {
      highlight();
    }
    
    stroke(#000000);
    strokeWeight(ceil(size*0.01));
    
    line(x + size/3, y + size*0.1, x + size/3, y + size*0.9);
    line(x + size*2/3, y + size*0.1, x + size*2/3, y + size*0.9);
    
    line(x + size*0.1, y + size/3, x + size*0.9, y + size/3);
    line(x + size*0.1, y + size*2/3, x + size*0.9, y + size*2/3);
    
    strokeWeight(ceil(size*0.02));
    noFill();
    for (int i = 0; i < 3; i ++){
      for (int j = 0; j < 3; j ++){
        if (fields[i][j] == 1){
          stroke(#FF0000);
          line(x + size * (0.05 + i/3.), y + size * (0.05 + j/3.),
            x + size * (- 0.05 + (i+1)/3.), y + size * (-0.05 + (j+1)/3.));
          line(x + size * (0.05 + i/3.), y + size * (-0.05 + (j+1)/3.),
            x + size * (- 0.05 + (i+1)/3.), y + size * (0.05 + j/3.));
      }
      else if (fields[i][j] == 2){
          stroke(#4287f5);
          circle(x + size * (1/6. + i/3.), y + size * (1/6. + j/3.), size*0.23);
        }
      }
    }
  }
  
  int getField(int i, int j) {
    return fields[i][j];
  }
  
  // Startindex und Positionsaenderung
  boolean checkLine(int i, int j, int incI, int incJ) {
    int candidate = getField(i, j);
    if (candidate == 0) {
      return false;
    }
    while(i < 3 && j < 3) {
      if (candidate != getField(i, j)) {
        return false;
      }
      i += incI;
      j += incJ;
    }
    winner = candidate;
    return true;
  }
  
  void checkWin() {
    for (int i = 0; i < 3; i++) {
      if (checkLine(0, i, 1, 0) || checkLine(i, 0, 0, 1)) return;
    }
    // Diagonale
    if (checkLine(0, 0, 1, 1) || checkLine(2, 0, -1, 1)) return;
    
    // falls alle 9 Felder belegt sind, setze Winner auf 3 (= UNENTSCHIEDEN)
    
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (getField(i, j) == 0) {
          return; // verlasse Funktion sofort, falls ein leeres Feld gefunden wurde
        }
      }
    }
    winner = 3;
  }
  
  boolean mousePressed() {
    if (winner != 0) {
      return false;
    }
    int i = (mouseX - x) / (size / 3);
    int j = (mouseY - y) / (size / 3);
    if (fields[i][j] == 0) {
      fields[i][j] = game.currentPlayer;
      game.active[0][0] = i;
      game.active[0][1] = j;
      checkWin();
      return true;
    }
    return false;
  }
  
  void highlight() {
    fill(255,255,0);
    noStroke();
    rect(x, y, size, size);
  }
  
  boolean isValidMove(int i, int j){
    return fields[i][j] == 0;
  }
  
  int countValidMoves(){
    int count = 0;
    for (int i = 0; i < 3; i++){
      for (int j = 0; j < 3; j++){
        if (isValidMove(i,j)) count++;
      }
    }
    return count;
  }
  
  void makeRandomMove(){
    int move = int(random(countValidMoves()));
    for (int i = 0; i < 3; i++){
      for (int j = 0; j < 3; j++){
        if (isValidMove(i,j)) {
          if (move == 0) makeRandomMoveIn(i,j);
          move --;
        }
      }
    }
  }
  
  void makeRandomMoveIn(int i, int j){
    fields[i][j] = game.currentPlayer;
    game.active[0][0] = i;
    game.active[0][1] = j;
    checkWin();
  }
  
  SimpleBoard copy (Game game){
    SimpleBoard copy = new SimpleBoard(game, x, y, size);
    for(int i = 0; i < 3; i++){
      for(int j = 0; j < 3; j++){
        copy.fields[i][j] = fields[i][j];
      }
    }
    copy.checkWin();
    return copy;
  }
  
  ArrayList<Game> allMoves() {
    ArrayList<Game> moves = new ArrayList();
    for (int i = 0; i < 3; i++){
      for (int j = 0; j < 3; j++){
        if (isValidMove(i,j)) {
          moves.addAll(allMovesIn(i, j));
        }
      }
    }
    return moves;
  }
  
  ArrayList<Game> allMovesIn(int i, int j){
    fields[i][j] = game.currentPlayer;
    Game copy = game.copy();
    fields[i][j] = 0;
    copy.active[0][0] = i;
    copy.active[0][1] = j;
    copy.nextTurn();
    
    ArrayList<Game> moves = new ArrayList();
    moves.add(copy);
    return moves;
  }
  
  void makeMove(int[][] move){
    int i = move[0][0];
    int j = move[0][1];
    fields[i][j] = game.currentPlayer;
    game.active[0][0] = i;
    game.active[0][1] = j;
    checkWin();
  }

}
