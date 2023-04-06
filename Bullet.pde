class Bullet extends Entity
{
  float speed;
  
  Bullet(float x, float y, float rot)
  {
    super(x, y, rot, 1.0, "bullet.png");
  }
  
  public void update()
  {
    move();
  }
}
