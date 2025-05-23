class Montecarlo extends Player {
  MontecarloTree tree;
  
  public Montecarlo(Game game, int nr){
    super(game, nr);
  }
  
  void makeMove(){
    tree = new MontecarloTree(game.copy());
    for (int i = 0; i < 1000; i++) tree.expand();
    float maxRatio = -100;
    int[][] move = null;
    for (MontecarloTree child : tree.children){
      float ratio = child.wins[game.currentPlayer-1] / float(child.wins[0]+child.wins[1]);
      if (child.sureWinner == game.currentPlayer)
        ratio += 10.0;
      else if (child.sureWinner != 0 && child.sureWinner != 3)
        ratio -= 10.0;
      if (ratio >= maxRatio){
        maxRatio = ratio;
        move = child.game.active;
      }
    }
    println("win chance: " + maxRatio);
    game.board.makeMove(move);
    game.nextTurn();
  }
}

class MontecarloTree {
  Game game;
  int[] wins; 
  int sureWinner = 0;
  ArrayList<MontecarloTree> children;
  
  MontecarloTree(Game game) {
    this.game = game;
    sureWinner = game.board.winner;
    wins = new int[2];
    for (int i = 0; i < 10; i ++)
    playout();
  }
  
  public void playout(){
    Game simulation = game.copy();
    simulation.players[0] = new RandomBot(simulation, 0);
    simulation.players[1] = new RandomBot(simulation, 1);
    simulation.run();
    if (simulation.board.winner == 1){
      wins [0] += 2;
    }
    else if (simulation.board.winner == 2){
      wins [1] += 2;
    } else {
      wins[0] ++;
      wins[1] ++;
    }
  }
  
  public void expand(){
    //println("expand");
    if (children == null){
      //println("creating children");
      children = new ArrayList();
      int childrenSureWinner = -1;
      for(Game move : game.board.allMoves()){
        MontecarloTree child = new MontecarloTree(move);
        children.add(child);
        wins[0] += child.wins[0];
        wins[1] += child.wins[1];
        
        if (child.sureWinner == game.currentPlayer)
          sureWinner = game.currentPlayer;
        if (childrenSureWinner == -1 || childrenSureWinner == child.sureWinner)
          childrenSureWinner = child.sureWinner;
        else
          childrenSureWinner = 0;
      }
      if (childrenSureWinner != 0) sureWinner = childrenSureWinner;
      //println(children.size());
    } else if (! children.isEmpty()) {
      //println("selecting child");
      float maxScore = 0;
      MontecarloTree selected = null;
      for (MontecarloTree child : children){
        float score = child.wins[game.currentPlayer-1]/float(child.wins[0] + child.wins[1])
          + 1.4 * sqrt(log((wins[0]+wins[1])/2) / (child.wins[0] + child.wins[1]) * 2);
        if (score >= maxScore){
          selected = child;
          maxScore = score;
        }
      }
      wins[0] -= selected.wins[0];
      wins[1] -= selected.wins[1];
      selected.expand();
      wins[0] += selected.wins[0];
      wins[1] += selected.wins[1];
    }
  }
}
