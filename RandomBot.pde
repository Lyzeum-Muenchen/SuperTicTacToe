class RandomBot extends Player {
  
  RandomBot(Game game){
    super(game);
  }
  
  void makeMove(){    
    game.board.makeRandomMove();
    game.nextTurn();
  }
  
}
