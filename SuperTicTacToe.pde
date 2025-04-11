SimpleBoard board;

int currentPlayer = 1; // 1 oder 2

void setup(){
  size(640, 640);
  board = new SuperBoard(20, 20, 600);
}

void draw(){
  background(currentPlayer == 1 ? #FF0000: #4287f5);
  noStroke();
  fill(255);
  rect(20, 20, 600, 600);
  board.draw();
}

void mousePressed() {
  if (mouseX >= 20 && mouseY >= 20 && mouseX < width - 20 && mouseY < height - 20) {
    board.mousePressed();
  }
}
