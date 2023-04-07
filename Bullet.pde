class Bullet extends Entity
{
  boolean isHit = false;
  
  float damage = 10;
  
  Bullet(float x, float y, float rot)
  {
    super(x, y, rot, 3.0, "bullet.png");
  }
  
  public void update(Game g)
  {
    drawEntity();
    
    move();
    
    damageZombie(g.zombies);
  }
  
  public void damageZombie(ArrayList<Zombie> zombies)
  {
    for (Zombie z: zombies)
    {
      if (dist(this.x, this.y, z.x, z.y) < 5)
      {
          z.damaged(damage);
          this.isHit = true;
      }
    }
  }
  
  public boolean shouldBeRemoved()
  {
    boolean outOfBounds = x > width || x < 0 || y > height || y < 0;
    
    return isHit || outOfBounds;
  }
}
