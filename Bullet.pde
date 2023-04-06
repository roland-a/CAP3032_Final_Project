class Bullet extends Entity
{
  float speed;
  
  Bullet(float x, float y, float rot)
  {
    super(x, y, rot, 5.0, "bullet.png");
  }
  
  public void update(Game g)
  {
    drawEntity();
    
    move();
  }
  
  public void damageZombie(ArrayList<Zombie> zombies)
  {
    
  }
  
  public boolean isOutOfBounds()
  {
    return (x > width || x < 0 || y > height || y < 0);
  }
}
