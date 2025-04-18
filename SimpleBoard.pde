class SimpleBoard {
  int x, y;
  int size;
  int[][] fields;
  int winner; // 1 oder 2, falls Sieger feststeht
  int[] lastMove = new int[2];

  SimpleBoard (int x, int y, int size) {
    this.size = size;
    this.x = x;
    this.y = y;
    fields = new int[3][3];
    winner = 0;
  }
  
  void draw() {
    stroke(#000000);
    strokeWeight(4);
    
    line(x + size/3, y + size*0.1, x + size/3, y + size*0.9);
    line(x + size*2/3, y + size*0.1, x + size*2/3, y + size*0.9);
    
    line(x + size*0.1, y + size/3, x + size*0.9, y + size/3);
    line(x + size*0.1, y + size*2/3, x + size*0.9, y + size*2/3);
    
    strokeWeight(4);
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
    checkLine(0, 0, 1, 1);
    checkLine(2, 0, -1, 1);
    
    // falls alle 9 Felder belegt sind, setze WInner auf 3 (= UNENTSCHIEDEN)
    
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
      fields[i][j] = currentPlayer;
      currentPlayer = 3 - currentPlayer;
      lastMove[0] = i;
      lastMove[1] = j;
      checkWin();
    }
    return true;
  }
  
  int[] getLastMove() {
    return lastMove;
  }
}
