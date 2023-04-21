//Gets a random mouse position
GamePos randomScreenPos()
{
  return new GamePos(
    random(width-20)+10,
    random(height-20)+10
  );
}

//Gets the position of the mouse
GamePos getMousePos()
{
  return new GamePos(mouseX, mouseY);
}


class GamePos
{
  final float x;
  final float y;
  
  GamePos(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  //offsets the position by angle and distance
  GamePos move(Angle a, float distance)
  {
    return new GamePos(
      this.x + a.cos()*distance,
      this.y + a.sin()*distance
    );
  }
  
  //returns the distance between this position and the target psoition
  float distanceTo(GamePos target)
  {
    return dist(this.x, this.y, target.x, target.y);
  }
  
  //Returns the angle between this position and the target position
  Angle pointTo(GamePos target)
  {
    return new Angle(
      atan2(target.y-this.y, target.x-this.x)
    );
  }
  
  //Returns true if the position is out of bounds
  boolean isOutOfBounds(){
    return this.x > width || this.x < 0 || this.y > height || this.y < 0;
  }
}
