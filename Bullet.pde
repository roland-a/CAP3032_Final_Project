abstract class Bullet extends Entity
{
  boolean isHit = false;
  
  int damage = 10;
  
  Bullet(float x, float y, float rot)
  {
    super(x, y, rot, 10.0, "bullet.png");
  }
  
  public void update(Game g)
  {
    drawEntity();
    
    move(true);
    
    damage(g);
  }
  
  public void damage(Game g)
  {
    for (Zombie z: g.zombies)
    {
      if (!canHit(z)) continue;
      
      if (dist(this.x, this.y, z.x, z.y) < 10)
      {
          z.damaged(damage);
          this.isHit = true;
      }
    }
    
    for (Soldier s: g.soldiers)
    {
      if (!canHit(s)) continue;
      
      if (dist(this.x, this.y, s.x, s.y) < 10)
      {
          s.damaged(damage);
          this.isHit = true;
      }
    }
  }
  
  abstract boolean canHit(Entity e);
  
  public boolean shouldBeRemoved()
  {
    return isHit || outOfBounds();
  }
}
