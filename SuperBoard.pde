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

  @Override
  void draw() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        subBoards[i][j].draw();
        if (subBoards[i][j].winner != 0) {
          drawWinningMark(subBoards[i][j].winner, x + i * size / 3, y + j * size / 3, size / 3);
        }
      }
    }
    stroke(#000000);
    strokeWeight(8);
    line(x + size/3, y + size*0.05, x + size/3, y + size*0.95);
    line(x + size*2/3, y + size*0.05, x + size*2/3, y + size*0.95);
    line(x + size*0.05, y + size/3, x + size*0.95, y + size/3);
    line(x + size*0.05, y + size*2/3, x + size*0.95, y + size*2/3);

  }

  void drawWinningMark(int winner, int x, int y, int size) {
    pushStyle();
    PGraphics overlay = createGraphics(size, size);
    overlay.beginDraw();
    float thickness = size / 10.0;
    if (winner == 1) {
      overlay.noStroke();
      overlay.fill(#ff0000);
      overlay.pushMatrix();
      overlay.translate(size / 2, size / 2);
      overlay.rotate(PI / 4);
      overlay.rectMode(CENTER);
      overlay.rect(0, 0, size, thickness);
      overlay.popMatrix();
      overlay.pushMatrix();
      overlay.translate(size / 2, size / 2);
      overlay.rotate(-PI / 4);
      overlay.rectMode(CENTER);
      overlay.rect(0, 0, size, thickness);
      overlay.popMatrix();
    } else if (winner == 2) {
      overlay.noFill();
      overlay.stroke(#4287f5);
      overlay.strokeWeight(thickness);
      overlay.ellipseMode(CENTER);
      overlay.circle(size / 2, size / 2, size * 0.8 - thickness/2);
    }
    overlay.endDraw();
    tint(255, 150);
    image(overlay, x, y);
    popStyle();
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