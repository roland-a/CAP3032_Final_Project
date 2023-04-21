abstract class Bullet extends Entity
{
  boolean isHit = false;
  
  Bullet(GamePos pos, Angle rot)
  {
    super(.5, "bullet.png");
    
    this.speed = 10;
    this.radius = 5;
    
    this.pos = pos;
    this.angle = rot;
  }
  
  public void update(Game g)
  {
    this.drawEntity();
    
    this.pos = this.pos.move(this.angle, this.speed);
    
    this.damage(g);
  }
  
  public void damage(Game g)
  {
    for (Zombie z: g.zombies)
    {
      if (this.distance(z) < this.radius+z.radius)
      {
          this.isHit = interact(z);
          if (this.isHit) return;
      }
    }
    
    for (Soldier s: g.soldiers)
    {
      if (this.distance(s) < this.radius+s.radius)
      {
          this.isHit = interact(s);
          if (this.isHit) return;
      }
    }
  }
  
  abstract boolean interact(Entity e);
  
  public boolean isAlive()
  {
    return !this.isHit && !this.pos.isOutOfBounds();
  }
}
