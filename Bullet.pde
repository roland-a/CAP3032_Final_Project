abstract class Bullet extends Entity
{
  
  //whether the bullet has hit an entity it can interact with
  boolean hasHit = false;
  
  Bullet(GamePos pos, Angle rot)
  {
    super(.5, "bullet.png");
    
    this.speed = 10;
    this.radius = 5;
    
    this.pos = pos;
    this.angle = rot;
  }
  
  @Override
  public void update(Game g)
  {
    this.drawEntity();
    
    this.pos = this.pos.move(this.angle, this.speed);
    
    for (Zombie z: g.zombies)
    {
      if (this.distanceTo(z) < this.radius+z.radius)
      {
          this.hasHit = interact(z);
          if (this.hasHit) return;
      }
    }
    
    for (Soldier s: g.soldiers)
    {
      if (this.distanceTo(s) < this.radius+s.radius)
      {
          this.hasHit = interact(s);
          if (this.hasHit) return;
      }
    }
  }
  
  //returns whether the bullet can interact with an entity
  //interacts with it if returns true
  abstract boolean interact(Entity e);
  
  
  //The bullet is alive if it has not hit an entity, and it is not out of bounds
  @Override
  public boolean isAlive()
  {
    return !this.hasHit && !this.pos.isOutOfBounds();
  }
}
