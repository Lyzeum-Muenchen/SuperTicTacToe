abstract class Player {
  Game game;
  
  Player(Game game){
    this.game = game;
  }
  
  abstract void makeMove();
  void mousePressed() {}
  
}
