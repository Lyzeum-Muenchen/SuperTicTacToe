abstract class Player {
  Game game;
  int nr;
  
  Player (Game game, int nr){
    this.game = game;
    this.nr = nr;
  }
  
  
  abstract void makeMove();
  void mousePressed() {}
  
}
