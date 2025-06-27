class MonteCarloBot extends Player {
  
  MonteCarloTree tree;
  
  public MonteCarloBot(Game game) {
    super(game);
  }
  
  void makeMove() {
    tree = new MonteCarloTree(game.copy());
    
    for(int i = 0; i < 10000; i++){
      tree.expand();
    }
    
    float bestScore = -1;
    MonteCarloTree bestMove = null;
    
    for (MonteCarloTree move : tree.children) {
      
      float score = move.ratio();
      
      if (score >= bestScore){
        bestScore = score;
        bestMove = move;
      }
      
    }
    
    println("Gewinnwahrscheinlichkeit: " + bestScore);
    
    game.board.makeMove(bestMove.game.active);
    game.nextTurn();
    
  }
  
}
