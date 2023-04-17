class GamePos
{
  final float x;
  final float y;
  
  GamePos(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  GamePos move(Angle a, double speed){
    return new GamePos(
      this.x + a.cos()*speed;
      this.y + a.cos()*speed;
    );
  }
  
  Angle pointTo(GamePos target)
  {
    return new Angle(
      atan2(target.y-y, target.x-x)
    )  
  }
}
