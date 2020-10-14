public class Tile{
  int sizeX, sizeY;
  int x, y;
  int value = 0;
  int flag = 0;
  boolean isRevealed = false;
  boolean isPressed = false;
  
  public Tile(int x, int y, int sizeX, int sizeY){
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.x = x;
    this.y = y;
  }
  
  public void changeSize(int sizeX,int sizeY){
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  
  public void render(){
    if(!isRevealed){
      //Outer Square
      fill(200);
      stroke(100);
      strokeWeight(2);
      rect(x*sizeX, y*sizeY, sizeX, sizeY);
      //Lines
      strokeWeight(1);
      stroke(130);
      line(x*sizeX, y*sizeY, x*sizeX+sizeX, y*sizeY+sizeY);
      line(x*sizeX+sizeX, y*sizeY, x*sizeX, y*sizeY+sizeY);
      //Inner Square
      if(!isPressed && flag == 0) fill(210);
      else if(!isPressed && flag == 1) fill(210, 0, 0);
      else if(!isPressed && flag == 2) fill(210, 210, 0);
      else fill(160);
      rect(x*sizeX+sizeX/4, y*sizeY+sizeY/4, sizeX/2, sizeY/2);
      stroke(0);
    }
    else{
      fill(210);
      strokeWeight(2);
      stroke(100);
      rect(x*sizeX, y*sizeY, sizeX, sizeY);
      fill(0);
      textSize(10);
      text(value, x*sizeX+sizeX/2-5, y*sizeY+sizeY/2+5);
    }
    
    if(isPressed && (!mousePressed || mouseX/sizeX != x || mouseY/sizeY != y)){
      isPressed = false;
    }
  }
  
  public void pressed(){
    isPressed = true;
  }
  
  public void iterFlag(){
    flag++;
    if(flag > 2) flag = 0;
  }
}
