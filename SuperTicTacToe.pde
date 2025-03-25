SimpleBoard board;
int currentPlayer = 1;

void setup(){
  size(600, 600);
  board = new SuperBoard(0, 0, 600);
}

void draw(){
    background(255);
    board.draw();
}

void mousePressed() {
  board.mousePressed();
}
