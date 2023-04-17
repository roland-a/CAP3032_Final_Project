class Angle
{
  final float angle;
  
  Angle(float angle)
  {
    this.angle = angle;  
  }
  
  Angle()
  {
    this(0); 
  }
  
  float cos()
  {
      return (float)Math.cos(this.angle);
  }
  
  float sin()
  {
    return (float)Math.sin(this.angle); 
  }
  
  Angle flip(){
    return new Angle(this.angle+180);  
  }
}
