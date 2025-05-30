Game game;

void setup(){
  size(769, 769);
  game = new Game(1, 20, 20, 729);
}

void draw(){
  background(game.currentPlayer == 1 ? #FF0000: #4287f5);
  noStroke();
  fill(255);
  rect(20, 20, 729, 729);
  game.draw();
}

void mousePressed() {
  game.mousePressed();
}
