class RandomBot extends Player{
  
  public RandomBot(Game game, int nr){
    super(game, nr);
  }
  
  public void makeMove(){
    game.board.makeRandomMove();
    game.nextTurn();
  }
  
}
