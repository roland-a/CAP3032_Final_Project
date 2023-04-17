class Angle
{
  final float angle;
  
  Angle(float angle)
  {
    this.angle = angle;  
  }
  
  float cos()
  {
      return (float)Math.cos(this.angle);
  }
  
  float sin()
  {
    return (float)Math.sin(this.angle); 
  }
}
