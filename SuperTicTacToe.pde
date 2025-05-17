Game game;

void setup(){
  size(640, 640);
  game = new Game(2, 20, 20, 600);
}

void draw(){
  background(game.currentPlayer == 1 ? #FF0000: #4287f5);
  noStroke();
  fill(255);
  rect(20, 20, 600, 600);
  game.draw();
}

void mousePressed() {
  game.mousePressed();
}
