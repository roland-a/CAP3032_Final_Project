class Soldier extends ShootingEntity
{
  public Soldier(GamePos pos)
  {
    super(.5, "soldier.png");
    
    this.pos = pos;
    this.angle = new Angle();
    
    this.speed = 2;
    
    this.health = 10; 
    this.maxBullets = 15;
    this.bulletCount = maxBullets;
    
    this.fireRatePerSecond = 5;
    this.reloadTime = 4;
  }

  public void update(Game g)
  {
    drawEntity();
    
    Zombie closest = this.closest(g.zombies);  
    if (closest == null) return;
    
    this.rotateTo(closest);

    this.shoot(g);
    
    if (this.distance(closest) < 50){
      this.move(false);
    }
    else {
      this.move(true);  
    }
  }
  
  boolean bulletCanHit(Entity t){
    return t instanceof Zombie;
  }
}
