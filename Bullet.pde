class Bullet extends Entity
{
  boolean isHit = false;
  
  float damage = 10;
  
  Bullet(float x, float y, float rot)
  {
    super(x, y, rot, 10.0, "bullet.png");
  }
  
  public void update(Game g)
  {
    drawEntity();
    
    move(true);
    
    damageZombie(g.zombies);
  }
  
  public void damageZombie(ArrayList<Zombie> zombies)
  {
    for (Zombie z: zombies)
    {
      if (dist(this.x, this.y, z.x, z.y) < 10)
      {
          z.damaged(damage);
          this.isHit = true;
      }
    }
  }
  
  public boolean shouldBeRemoved()
  {
    return isHit || outOfBounds();
  }
}
