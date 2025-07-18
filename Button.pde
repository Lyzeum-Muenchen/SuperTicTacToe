abstract class Button {
  
  int x;
  int y;
  int w;
  int h;
  
  String str;
  
  Button(int x, int y, int w, int h, String str){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.str = str;
  }
  
  void draw() {
    fill (255);
    stroke(0);
    strokeWeight(2);
    rect(x,y,w,h);
    textSize(30);
    fill(0);
    textAlign(CENTER,CENTER);
    text(str, x+w/2, y+h/2);
    
  }
  
  void mousePressed() {
    if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h){
      onClick();
    }
  }
  
  abstract void onClick();
  
}
