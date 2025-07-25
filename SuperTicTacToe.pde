Game game;
boolean isRunning = false;
String[] bots = {"Human", "Easy", "Medium", "Expert"};
String[] modi = {"TicTacToe", "Super", "Ultimate"};
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
  for (int i = 0; i < modi.length; i++){
    final int depth = i;
    buttons.add(new Button (50 + (width - 50)/modi.length*i, height - 100, (width - 50)/modi.length - 50, 50, modi[i]) { 
      void onClick() {
        game = new Game(depth, 20, 20, 729);
        game.players[0] = makePlayer(game, player1);
        game.players[1] = makePlayer(game, player2);
        game.players[0].makeMove();
        isRunning = true;
      }
    });
  }
  
}

void draw(){
  if (isRunning){
    background(game.currentPlayer == 1 ? #FF0000: #4287f5);
    noStroke();
    fill(255);
    rect(20, 20, 729, 729);
    game.draw();
    if (game.board.winner != 0){
      switch (game.board.winner) {
        case 1:
          fill(#FF0000);
          break;
        case 2:
          fill(#4287f5);
          break;
        case 3:
          fill(100);
      }
      textSize(150);
      textAlign(CENTER,CENTER);
      text("Good Game", width/2, height/2);
    }
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
    circle(width - 330, 350 + 50*player2 + 20, 40);
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

Player makePlayer(Game game, int type){
  switch(type){
    case 0:
      return new Human(game);
    case 1:
      return new MonteCarloBot(game, 100);
    case 2:
      return new MonteCarloBot(game, 1000);
    case 3:
      return new MonteCarloBot(game, 10000);
    default:
      return null;
  }
}

void keyPressed(){
  if(isRunning && game.board.winner != 0){
    isRunning = false;
  }
}
