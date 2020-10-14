import javax.swing.*;

public class Grid{
  int numX;
  int numY;
  int numBombs;
  int resX, resY;
  int numToReveal;
  Tile[][] tiles;
  Tile[] bombTiles;
  
  JFrame frame;
  
  public Grid(){
    newGameDialog();
  }
  //Take in screen coordinates and translate to grid coordinates
  public Tile getTileAt(int x, int y){
    if(x/resX<0 || x/resX>numX-1 || y/resY<0 || y/resY>numY-1) return null;
    return tiles[x/resX][y/resY];
  }
  //Reveal a tile using Screen coordinates
  public void revealTileAt(int x, int y){
    if(tiles[x/resX][y/resY].flag == 1) return; //Block misclicks on marked bombs
    
    revealTile(x/resX, y/resY);
  }
  //Reveal a tile using grid coordinates
  public void revealTile(int gx, int gy){
    if(gx<0 || gx>numX-1 || gy<0 || gy>numY-1) return;
    
    Tile tile = tiles[gx][gy];
    
    if(tile.value == -1) {
      loseDialog(); //Hit a bomb
      return;
    }
    if(tile.isRevealed) return; 
    
    tile.isRevealed = true;
    numToReveal-=1;
    if(numToReveal <= 0){
      winDialog();
    }
    
    if(tile.value > 0) return; //Only reveal more tiles if the current tile has no bombs near it
    
    for(int i = -1; i<=1; i++){
      for(int j = -1; j<=1; j++){
        if(i==0 && j==0) continue;
        int x = gx+i;
        int y = gy+j;
        revealTile(x, y);
      }
    }
  }
  
  public void render(){
    for(int x = 0; x<numX; x++){
      for(int y = 0; y<numY; y++){
        tiles[x][y].render();
      }
    }
  }
  
  //Go through tiles surrounding bombs and increment their value
  public void updateValues(Tile t){
    for(int x = -1; x<=1; x++){
      for(int y = -1; y<=1; y++){
        if(x == 0 && y == 0) continue;
        if(x+t.x < 0 || x+t.x > numX-1 || y+t.y < 0 || y+t.y > numY-1) continue;
        if(tiles[x+t.x][y+t.y].value != -1){
          tiles[x+t.x][y+t.y].value+=1;
        }
      }
    }
  }
  //Handling for screen resize
  public void changeSize(){
    if(resX == width/numX && resY == height/numY) return; //Don't resize if it's not needed
    
    resX = width/numX;
    resY = height/numY;
    for(int x = 0; x<numX; x++){
      for(int y = 0; y<numY; y++){
        tiles[x][y].changeSize(resX, resY);
      }
    }
  }
  
  public void init(int numX, int numY, int numBombs){
    this.numX = numX;
    this.numY = numY;
    tiles = new Tile[numX][numY];
    
    resX = width/numX;
    resY = height/numY;
    
    numToReveal = numX*numY;
    
    for(int x = 0; x<numX; x++){
      for(int y = 0; y<numY; y++){
        tiles[x][y] = new Tile(x, y, resX, resY);
      }
    }
    
        
    this.numBombs = numBombs;
    bombTiles = new Tile[numBombs];
    numToReveal -= numBombs;
    
    for(int i = 0; i<numBombs; i++){
      bombTiles[i] = tiles[(int)random(numX)][(int)random(numY)];
      bombTiles[i].value = -1;
      updateValues(bombTiles[i]);
    }
  }
  
  public void loseDialog(){
    frame = new JFrame();
    JOptionPane.showMessageDialog(frame, "You hit a bomb!");
    newGameDialog();
  }
  
  public void winDialog(){
    frame = new JFrame();
    JOptionPane.showMessageDialog(frame, "YOU WON!\nYou found all the bombs!");
    newGameDialog();
  }
  
  public void newGameDialog(){
    frame = new JFrame();
    Object[] options = {"Easy", "Medium", "Hard"};
    
    Object selectedOption = JOptionPane.showInputDialog(frame, "Choose one", "Input", JOptionPane.INFORMATION_MESSAGE, null, options, options[0]);
    
    if(selectedOption == "Easy") init(20, 20, 10);
    else if(selectedOption == "Medium") init(30, 30, 100);
    else if(selectedOption == "Hard") init(40, 40, 250);
    else exit();
  }
  
}
