class SuperBoard extends SimpleBoard {
  static final float THICKNESS_FACTOR = 0.8;
  SimpleBoard[][] subBoards;

  SuperBoard(int x, int y, int size, int depth, float currentThickness, int level) {
    super(x, y, size, currentThickness, level);
    subBoards = new SimpleBoard[3][3];
    int subSize = size / 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        int childX = x + i * subSize;
        int childY = y + j * subSize;
        if (depth == 1) {
          subBoards[i][j] = new SimpleBoard(childX, childY, subSize, currentThickness * THICKNESS_FACTOR, level+1);
        } else {
          subBoards[i][j] = new SuperBoard(childX, childY, subSize, depth - 1, currentThickness * THICKNESS_FACTOR, level+1);
        }
      }
    }
  }

  SuperBoard(int x, int y, int size, int depth) {
    this(x, y, size, depth, 1.0, 0);
  }
  
  SuperBoard(int x, int y, int size) {
    this(x, y, size, 1, 1.0, 0);
  }

  @Override
  void draw(boolean highlight) {
    int activeI = active[level+1][0];
    int activeJ = active[level+1][1];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        subBoards[i][j].draw(highlight && ! firstTurn && activeI == i && activeJ == j);
        if (subBoards[i][j].winner != 0) {
          drawWinningMark(subBoards[i][j].winner, x + i * size / 3, y + j * size / 3, size / 3);
        }
      }
    }

    stroke(#000000);
    strokeWeight(6 * thickness);
    line(x + size/3, y + size*0.05, x + size/3, y + size*0.95);
    line(x + size*2/3, y + size*0.05, x + size*2/3, y + size*0.95);
    line(x + size*0.05, y + size/3, x + size*0.95, y + size/3);
    line(x + size*0.05, y + size*2/3, x + size*0.95, y + size*2/3);

  }

  void drawWinningMark(int winner, int x, int y, int size) {
    pushStyle();
    PGraphics overlay = createGraphics(size, size);
    overlay.beginDraw();
    float markThickness = (size / 10.0) * thickness;
    if (winner == 1) {
      overlay.noStroke();
      overlay.fill(#ff0000);
      overlay.pushMatrix();
      overlay.translate(size / 2, size / 2);
      overlay.rotate(PI / 4);
      overlay.rectMode(CENTER);
      overlay.rect(0, 0, size, markThickness);
      overlay.popMatrix();
      overlay.pushMatrix();
      overlay.translate(size / 2, size / 2);
      overlay.rotate(-PI / 4);
      overlay.rectMode(CENTER);
      overlay.rect(0, 0, size, markThickness);
      overlay.popMatrix();
    } else if (winner == 2) {
      overlay.noFill();
      overlay.stroke(#4287f5);
      overlay.strokeWeight(markThickness);
      overlay.ellipseMode(CENTER);
      overlay.circle(size / 2, size / 2, size * 0.8 - markThickness/2);
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
  
  @Override
  boolean mousePressed() {
    if (winner != 0) return false;
    int i = (mouseX - x) / (size / 3);
    int j = (mouseY - y) / (size / 3);

    int activeI = active[level+1][0];
    int activeJ = active[level+1][1];

    if (! firstTurn && subBoards[activeI][activeJ].winner == 0  && (i != activeI || j != activeJ)) {
      return false;
    }

    if (subBoards[i][j].mousePressed()) {
      active[level][0] = i;
      active[level][1] = j;
      checkWin();
      return true;
    }
    return false;
  }
}
