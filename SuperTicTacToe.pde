SimpleBoard board;
int currentPlayer = 1;
boolean firstTurn = true;
int DEPTH = 2;
int[][] active = new int[DEPTH+1][2];

void setup(){
  size(640, 640);
  board = DEPTH > 0 ? new SuperBoard(20, 20, 600, DEPTH) : new SimpleBoard(20,20,600);
}

void draw(){
    background(currentPlayer == 1? #FF0000 : #4287f5);
    noStroke();
    fill(255);
    rect(20,20,600,600);
    board.draw(true);
}

void mousePressed() {
  if(mouseX >= 20 && mouseY >= 20 && mouseX < width - 20 && mouseY < height - 20){
    if (board.mousePressed()){
      currentPlayer = 3 - currentPlayer; // Spieler wechseln
      firstTurn = false;
    }
  }
}
