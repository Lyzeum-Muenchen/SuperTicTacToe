class SimpleBoard {
  int x, y;
  int size;
  int[][] fields;
  int currentPlayer = 1;

  SimpleBoard (int x, int y, int size) {
    this.size = size;
    this.x = x;
    this.y = y;
    fields = new int[3][3];
  }
  
  void draw() {
    stroke(#000000);
    strokeWeight(4);
    
    line(x + size/3, y + size*0.1, x + size/3, y + size*0.9);
    line(x + size*2/3, y + size*0.1, x + size*2/3, y + size*0.9);
    
    line(x + size*0.1, y + size/3, x + size*0.9, y + size/3);
    line(x + size*0.1, y + size*2/3, x + size*0.9, y + size*2/3);
    
    strokeWeight(4);
    noFill();
    for (int i = 0; i < 3; i ++){
      for (int j = 0; j < 3; j ++){
        if (fields[i][j] == 1){
          stroke(#FF0000);
          line(x + size * (0.05 + i/3.), y + size * (0.05 + j/3.),
            x + size * (- 0.05 + (i+1)/3.), y + size * (-0.05 + (j+1)/3.));
          line(x + size * (0.05 + i/3.), y + size * (-0.05 + (j+1)/3.),
            x + size * (- 0.05 + (i+1)/3.), y + size * (0.05 + j/3.));
      }
      else if (fields[i][j] == 2){
          stroke(#0000FF);
          circle(x + size * (1/6. + i/3.), y + size * (1/6. + j/3.), size*0.23);
        }
      }
    }
    
  }

  void mousePressed() {
    int i = (mouseX - x) / (size / 3);
    int j = (mouseY - y) / (size / 3);
    if (fields[i][j] == 0) {
      fields[i][j] = currentPlayer;
      currentPlayer = 3 - currentPlayer; // Spieler wechseln
    }
  }
  
}
