ScreenPos getMousePos()
{
  return new ScreenPos(mouseX, mouseY);
}

ScreenPos randomScreenPos()
{
  return new ScreenPos(
    (int)random(width),
    (int)random(height)
  );
}

class ScreenPos
{
  final int x;
  final int y;
  
  ScreenPos(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  GamePos toGamePos()
  {
    return new GamePos(this.x, this.y);
  }
  
  
}
