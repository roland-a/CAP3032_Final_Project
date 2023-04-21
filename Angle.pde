class Angle
{
  //The angle in degrees
  final float angle;
  
  Angle(float angle)
  {
    this.angle = angle;  
  }
  
  Angle()
  {
    this(0); 
  }
  
  //gets the cosine of the angle
  float cos()
  {
      return (float)Math.cos(this.angle);
  }
  
  //gets the sine of the angle
  float sin()
  {
    return (float)Math.sin(this.angle); 
  }
  
  //rotates the angle by n degrees
  Angle rotate(int delta){
    return new Angle(this.angle+delta);  
  }
}
