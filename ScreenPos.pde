class ScreenPos
{
  final int x;
  final int y;
  
  ScreenPos(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  static ScreenPos getMousePos()
  {
    return new ScrenPos(mouseX, mouseY);
  }
  
  Position toGamePos()
  {
    return new ScreenPos(this.x, this.y);
  }
  
  
}
