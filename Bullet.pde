abstract class Bullet extends Entity
{
  boolean isHit = false;
  
  int damage = 10;
  
  Bullet(GamePos pos, Angle rot)
  {
    super(.5, "bullet.png");
    
    this.speed = 10;
    this.pos = pos;
    this.angle = rot;
  }
  
  public void update(Game g)
  {
    this.drawEntity();
    
    this.move(true);
    
    this.damage(g);
  }
  
  public void damage(Game g)
  {
    for (Zombie z: g.zombies)
    {
      if (!this.canHit(z)) continue;
      
      if (this.distance(z) < 10)
      {
          z.damage(damage);
          this.isHit = true;
      }
    }
    
    for (Soldier s: g.soldiers)
    {
      if (!this.canHit(s)) continue;
      
      if (this.distance(s) < 10)
      {
          s.damage(damage);
          this.isHit = true;
      }
    }
  }
  
  abstract boolean canHit(Entity e);
  
  public boolean isAlive()
  {
    return !(this.isHit || this.outOfBounds());
  }
}
