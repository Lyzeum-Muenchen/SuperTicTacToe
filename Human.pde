class Human extends Player {
  
  boolean myTurn = false;
  
  public Human(Game game, int nr){
    super(game, nr);
  }
  
  public void makeMove(){
    myTurn = true;
  }
  
  public void mousePressed() {
   if (myTurn && game.board.mousePressed()) {
        myTurn = false;
        game.nextTurn();
    }
  }
  
}
