SimpleBoard board;
int currentPlayer = 1;
boolean firstTurn = true;
int DEPTH = 1;
int[][] active = new int[DEPTH+1][2];

void setup(){
  size(640, 640);
  board = new SuperBoard(20, 20, 600, DEPTH);
}

void draw(){
  background(currentPlayer == 1 ? #FF0000: #4287f5);
  noStroke();
  fill(255);
  rect(20, 20, 600, 600);
  board.draw();
}

void mousePressed() {
  if(mouseX >= 20 && mouseY >= 20 && mouseX < width - 20 && mouseY < height - 20){
    if (board.mousePressed()){
      currentPlayer = 3 - currentPlayer; // Spieler wechseln
      firstTurn = false;
    }
  }
}
