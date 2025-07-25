import java.util.Arrays;

class MonteCarloBot extends Player {
  
  MonteCarloTree tree;
  int difficulty;
  
  public MonteCarloBot(Game game, int difficulty) {
    super(game);
    this.difficulty = difficulty;
  }
  
  void makeMove() {
    
    if (game.firstTurn) {
      int[][] firstMove = new int[game.DEPTH+1][2];
      for (int i = 0; i < game.DEPTH + 1; i++){
        firstMove[i][0] = 1;
        firstMove[i][1] = 1;
      }
      game.board.makeMove(firstMove);
      game.nextTurn();
      return;
    }
    
    if (tree != null && tree.children != null){
      for (MonteCarloTree move : tree.children){
        if(Arrays.deepEquals(game.active, move.game.active)){
          tree = move;
          break;
        }
      }
    } else {  
      tree = new MonteCarloTree(game.copy());
    }
    
    for(int i = 0; i < difficulty; i++){
      tree.expand();
    }
    
    float bestScore = -1;
    MonteCarloTree bestMove = null;
    
    for (MonteCarloTree move : tree.children) {
            
      float score = move.ratio();
      //println("Move: " + Arrays.deepToString(move.game.active) + " Score: "+score+" Wins: " + Arrays.toString(move.wins));
      
      if (score >= bestScore){
        bestScore = score;
        bestMove = move;
      }
      
    }
    
    println("Gewinnwahrscheinlichkeit ("+game.currentPlayer+"): " + bestScore);
    tree = bestMove;
    game.board.makeMove(bestMove.game.active);
    game.nextTurn();
    
  }
  
}
