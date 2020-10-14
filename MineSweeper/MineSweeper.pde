Grid grid;

void setup(){
  size(800, 800);
  surface.setResizable(true);
  grid = new Grid();
}

void draw(){
  background(0);
  grid.render();
  grid.changeSize();
}

void mousePressed(){
  Tile tile = grid.getTileAt(mouseX, mouseY);
  if(tile != null) tile.pressed();
}

void mouseDragged(){
  Tile tile = grid.getTileAt(mouseX, mouseY);
  if(tile != null) tile.pressed();
}

void mouseReleased(){
  if(mouseButton == LEFT) grid.revealTileAt(mouseX, mouseY);
  else if(mouseButton == RIGHT){
    Tile tile = grid.getTileAt(mouseX, mouseY);
    tile.iterFlag();
  }
}
