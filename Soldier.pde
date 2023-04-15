class Soldier extends ShootingEntity
{
  public Soldier(float x, float y, float rot)
  {
    super(x, y, rot, 2, "soldier.png");

    health = 10; 
    maxBullets = 15;
    bulletCount = maxBullets;
    
    fireRatePerSecond = 5;
    reloadTime = 4;
  }

  public void update(Game g)
  {
    drawEntity();
    
    Zombie closest = this.closest(g.zombies);  
    if (closest != null)
    {
      this.rotateTo(closest);
  
      shoot(g);
    }
      
    if (closeToEntity(g.zombies))
    {
      move(false);
    }
    else
    {
      move(true);
    }
  }
  
  boolean bulletCanHit(Entity t){
    return t instanceof Zombie;
  }

  public void damaged(int damage)
  {
    health -= damage;
  }

  public boolean isAlive()
  {
    return health > 0;
  }
}
