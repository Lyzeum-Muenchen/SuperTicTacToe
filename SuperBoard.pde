class SuperBoard extends SimpleBoard {
  SimpleBoard[][] subBoards;

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
}