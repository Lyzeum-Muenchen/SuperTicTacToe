class Human extends Player {
  
  Human(Game game){
    super(game);
  }
  
  void makeMove() {}
  
  void mousePressed() {
    if (game.board.mousePressed()){
      game.nextTurn();
    }
  }
  
}
