class Bullet extends Entity
{
  boolean isHit = false;
  
  Bullet(float x, float y, float rot)
  {
    super(x, y, rot, 3.0, "bullet.png");
  }
  
  public void update(Game g)
  {
    drawEntity();
    
    move();
  }
  
  public void damageZombie(ArrayList<Zombie> zombies)
  {
    for (Zombie z: zombies)
    {
      if (dist(this.x, this.y, z.x, z.y) < 1)
      {
          z.health -= 1;
          this.isHit = true;
      }
    }
  }
  
  public boolean shouldBeRemoved()
  {
    if (this.isHit) return true; 
    
    return (x > width || x < 0 || y > height || y < 0);
  }
}
