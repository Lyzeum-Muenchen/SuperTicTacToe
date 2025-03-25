class SuperBoard extends SimpleBoard {
  SimpleBoard[][] subBoards;
  int activeI = -1, activeJ = -1;

  SuperBoard(int x, int y, int size) {
    super(x, y, size);
    subBoards = new SimpleBoard[3][3];
    int subSize = size / 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        subBoards[i][j] = new SimpleBoard(x + i * subSize, y + j * subSize, subSize);
      }
    }
  }

  void draw() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        subBoards[i][j].draw();
      }
    }
    stroke(#000000);
    strokeWeight(8);
    line(x + size/3, y + size*0.05, x + size/3, y + size*0.95);
    line(x + size*2/3, y + size*0.05, x + size*2/3, y + size*0.95);
    line(x + size*0.05, y + size/3, x + size*0.95, y + size/3);
    line(x + size*0.05, y + size*2/3, x + size*0.95, y + size*2/3);
  }

  @Override
  int getField(int i, int j) {
    return subBoards[i][j].winner;
  }
  
  boolean mousePressed() {
    if (winner != 0) return false;
    int i = (mouseX - x) / (size / 3);
    int j = (mouseY - y) / (size / 3);

    if (activeI != -1 && (i != activeI || j != activeJ)) {
      return false;
    }

    if (subBoards[i][j].mousePressed()) {
      int[] lastMove = subBoards[i][j].getLastMove();
      activeI = lastMove[0];
      activeJ = lastMove[1];

      this.lastMove[0] = i;
      this.lastMove[1] = j;

      if (subBoards[activeI][activeJ].winner != 0) {
        activeI = -1;
        activeJ = -1;
      }

      checkWin();
      return true;
    }
    return false;
  }
}