
class GamePos
{
  final float x;
  final float y;
  
  GamePos(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  GamePos move(Angle a, float speed)
  {
    return new GamePos(
      this.x + a.cos()*speed,
      this.y + a.sin()*speed
    );
  }
  
  float distanceTo(GamePos other)
  {
    return dist(this.x, this.y, other.x, other.y);
  }
  
  Angle pointTo(GamePos target)
  {
    return new Angle(
      atan2(target.y-this.y, target.x-this.x)
    );
  }
  
  boolean isOutOfBounds(){
    return this.x > width || this.x < 0 || this.y > height || this.y < 0;
  }
  
  ScreenPos toScreenPos(){
    return new ScreenPos((int)this.x, (int)this.y);  
  }
}
