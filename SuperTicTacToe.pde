Game game;
boolean isRunning = false;
String[] bots = {"Human", "Easy", "Medium", "Expert"};
ArrayList<Button> buttons;
int player1;
int player2;

void setup(){
  size(769, 769);
  buttons = new ArrayList();
  for (int i = 0; i < bots.length; i++){
    final int index = i;
    buttons.add(new Button(50, 350 + 50*i, 250, 40, bots[i]){ 
      void onClick(){
        player1 = index;
      }
    });
    buttons.add(new Button(width - 300, 350 + 50*i, 250, 40, bots[i]){
      void onClick(){
        player2 = index;
      }
    });
  }
  // game = new Game(1, 20, 20, 729);
}

void draw(){
  if (isRunning){
    background(game.currentPlayer == 1 ? #FF0000: #4287f5);
    noStroke();
    fill(255);
    rect(20, 20, 729, 729);
    game.draw();
  } else {
    background(255);
    stroke(#FF0000);
    strokeWeight(10);
    line(50, 50, 300, 300);
    line(50,300, 300, 50);
    stroke(#4287f5);
    noFill();
    circle(width - 175, 175, 250);
    for (Button button : buttons){
      button.draw();
    }
    noStroke();
    fill(#FF0000);
    circle(330, 350 + 50*player1 + 20, 40);
    fill(#4287f5);
    circle(width - 330, 350 + 50*player1 + 20, 40);
  }
}

void mousePressed() {
  if (isRunning) {
    game.mousePressed();
  } else {
    for (Button button : buttons){
      button.mousePressed();
    }
  }
}
