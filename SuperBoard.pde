class SuperBoard extends SimpleBoard {
  SimpleBoard[][] subBoards;
  int depth;

  public SuperBoard(Game game, int x, int y, int size, int depth) {
    super(game, x, y, size);
    this.depth = depth;
    subBoards = new SimpleBoard[3][3];
    int subSize = size / 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (depth == 1){
          subBoards[i][j] = new SimpleBoard(game, x + i * subSize, y + j * subSize, subSize);
        } else {
          subBoards[i][j] = new SuperBoard(game, x + i * subSize, y + j * subSize, subSize, depth - 1);
        }
      }
    }
  }


  @Override
  void draw(boolean isActive) {
    int activeI = game.active[depth-1][0];
    int activeJ = game.active[depth-1][1];
    
    if (isActive && subBoards[activeI][activeJ].winner != 0){
      highlight();
    }
    
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        subBoards[i][j].draw(isActive && subBoards[i][j].winner == 0 && i == activeI && j == activeJ);
        if (subBoards[i][j].winner != 0) {
          drawWinningMark(subBoards[i][j].winner, x + i * size / 3, y + j * size / 3, size / 3);
        }
      }
    }
    stroke(#000000);
    strokeWeight(ceil(size*0.01));
       line(x + size / 3, y + size * 0.05, x + size / 3, y + size * 0.95);
    line(x + size * 2 / 3, y + size * 0.05, x + size * 2/3, y + size * 0.95);
    
    line(x + size * 0.05, y + size / 3, x + size * 0.95, y + size / 3);
    line(x + size * 0.05, y + size * 2 / 3, x + size * 0.95, y + size * 2 / 3);
  }
  
  void drawWinningMark(int winner, int x, int y, int size) {
    pushStyle();
    PGraphics overlay = createGraphics(size, size);
    overlay.beginDraw();
    float thickness = size / 10.0;
    if (winner == 1) {
      // Kreuz zeichnen
      overlay.noStroke();
      overlay.fill(#ff0000);
      overlay.pushMatrix();
      overlay.translate(size / 2, size / 2); // Verschiebung der Graphic
      overlay.rotate(PI / 4); // Drehung um 45 Grad
      overlay.rectMode(CENTER);
      overlay.rect(0, 0, size, thickness);
      overlay.popMatrix();
      overlay.pushMatrix();
      overlay.translate(size/2, size / 2);
      overlay.rotate(-PI / 4);
      overlay.rectMode(CENTER);
      overlay.rect(0, 0, size, thickness);
      overlay.popMatrix();
    } else if (winner == 2) {
      overlay.noFill();
      overlay.stroke(#4287f5);
      overlay.strokeWeight(thickness);
      overlay.ellipseMode(CENTER);
      overlay.circle(size / 2, size / 2, size * 0.8 - thickness / 2);
    }
    overlay.endDraw();
    tint(255, 150);
    image(overlay, x, y);
    popStyle();
  }
  
  @Override
  boolean mousePressed() {
    if (winner != 0) {
      return false;
    }
    int i = (mouseX - x) / (size / 3);
    int j = (mouseY - y) / (size / 3);
    
    int activeI = game.active[depth-1][0];
    int activeJ = game.active[depth-1][1];
    
    // falls aktives Board gesetz wurde UND Mausklick sich nicht im aktiven SubBoard befindet
    if ((! game.firstTurn) && (i != activeI || j != activeJ) && subBoards[activeI][activeJ].winner == 0) {
      return false;
    }
    
    if (subBoards[i][j].mousePressed()) {
      game.active[depth][0] = i;
      game.active[depth][1] = j;
      
      checkWin();
      
      return true;
    }
    return false;
  }
  
  int getField (int i, int j){
    return subBoards[i][j].winner;
  }
  
}
