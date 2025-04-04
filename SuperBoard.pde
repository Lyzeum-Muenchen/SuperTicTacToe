class SuperBoard extends SimpleBoard {
  SimpleBoard[][] subBoards;
  int activeI = -1; // Index des aktiven Boardes
  int activeJ = -1;

  public SuperBoard(int x, int y, int size) {
    super(x, y, size);
    subBoards = new SimpleBoard[3][3];
    int subSize = size / 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        subBoards[i][j] = new SimpleBoard(x + i * subSize, y + j * subSize, subSize);
      }
    }
  }


  @Override
  void draw() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        subBoards[i][j].draw();
      }
    }
    stroke(#000000);
    strokeWeight(8);
       line(x + size / 3, y + size * 0.05, x + size / 3, y + size * 0.95);
    line(x + size * 2 / 3, y + size * 0.05, x + size * 2/3, y + size * 0.95);
    
    line(x + size * 0.05, y + size / 3, x + size * 0.95, y + size / 3);
    line(x + size * 0.05, y + size * 2 / 3, x + size * 0.95, y + size * 2 / 3);
  }
  
  @Override
  boolean mousePressed() {
    if (winner != 0) {
      return false;
    }
    int i = (mouseX - x) / (size / 3);
    int j = (mouseY - y) / (size / 3);
    
    // falls aktives Board gesetz wurde UND Mausklick sich nicht im aktiven SubBoard befindet
    if (activeI != -1 && (i != activeI || j != activeJ)) {
      return false;
    }
    
    if (subBoards[i][j].mousePressed()) {
      int[] subBoardLastMove = subBoards[i][j].getLastMove();
      // Position des gesetzen Feldes im Subboard bestimmt naechstes 
      activeI = subBoardLastMove[0];
      activeJ = subBoardLastMove[1];
      
      lastMove[0] = i;
      lastMove[1] = j;
      
      // TODO Spezialfall: Falls subBoard einen Gewinner hat
      
      
      return true;
    }
    return false;
  }
}
