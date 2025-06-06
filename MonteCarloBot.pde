class MonteCarloBot extends Player {
  
  public MonteCarloBot(Game game) {
    super(game);
  }
  
  void makeMove() {
    ArrayList<Game> moves = game.board.allMoves();
    
    int bestScore = 0;
    Game bestMove = null;
    
    for (Game move : moves) {
      int[] wins = new int[2];
      for (int i = 0; i < 50; i ++){
        Game copy = move.copy();
        copy.players[0] = new RandomBot(copy);
        copy.players[1] = new RandomBot(copy);
        copy.run();
        switch (copy.board.winner) {
          case 1:
            wins[0] += 2;
            break;
          case 2:
            wins[1] += 2;
            break;
          default:
            wins[0] ++;
            wins[1] ++;
        }        
      }
      
      int score = wins[game.currentPlayer - 1];
      
      if (score >= bestScore){
        bestScore = score;
        bestMove = move;
      }
      
    }
    
    println("Gewinnwahrscheinlichkeit: " + bestScore + " %");
    
    game.board.makeMove(bestMove.active);
    game.nextTurn();
    
  }
  
}
