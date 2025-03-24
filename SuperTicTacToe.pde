SimpleBoard board;

void setup(){
  size(600, 600);
  board = new SimpleBoard(0, 0, 600);
}

void draw(){
    background(255);
    board.draw();
}

void mousePressed() {
  board.mousePressed();
}
