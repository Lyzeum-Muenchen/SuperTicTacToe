class MonteCarloTree {
  Game game;
  ArrayList<MonteCarloTree> children;
  int[] wins;

  MonteCarloTree(Game game) {
    this.game = game;
    wins = new int[2];
    for (int i = 0; i < 10; i++){
      playout();
    }
  }

  public void playout() {
    Game copy = game.copy();
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
  
  public void expand () {
    if (children == null){
      children = new ArrayList();
      for (Game move : game.board.allMoves()){
        MonteCarloTree child = new MonteCarloTree(move);
        children.add(child);
        wins[0] += child.wins[0];
        wins[1] += child.wins[1];
      }
    } else if (! children.isEmpty()) {
      float bestScore = -1;
      MonteCarloTree bestMove = null;
      
      for (MonteCarloTree move : children) {
        
        float score = move.ratio() + 1.4 * sqrt(log(wins[0]+wins[1]/2) / ((move.wins[0]+move.wins[1])/2));
        
        if (score >= bestScore){
          bestScore = score;
          bestMove = move;
        }
        
      }
      
      wins[0] -= bestMove.wins[0];
      wins[1] -= bestMove.wins[1];
      bestMove.expand();
      wins[0] += bestMove.wins[0];
      wins[1] += bestMove.wins[1];
      
    } else {
      switch (game.board.winner) {
        case 1:
          wins[0] += 20;
          break;
        case 2:
          wins[1] += 20;
          break;
        default:
          wins[0] += 10;
          wins[1] += 10;
        }
    }
  }
  
  public float ratio (){
    return wins[2 - game.currentPlayer] / float (wins[0] + wins[1]);
  }
  
  
}
