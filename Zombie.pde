class Zombie extends Entity
{
  int health;
  int damage;
  
  boolean main;
  
  Zombie(float x, float y, float rot)
  {
    super(x, y, rot, 1.0, "zombie.png");
    
    this.health = 50;
    damage = 10;
    
    main = false;
  }
  
  public void update(Game g)
  {
    drawEntity();
    
    if (main)
    {
      mainUpdate(g);
    }
    else
    {
      hordeUpdate(g);
    }
  }
  
  public void mainUpdate(Game g)
  {
    drawEntity();
    
    this.rot = atan2(g.x, g.y);
    
    this.attack(g);
  }
  
  public void hordeUpdate(Game g)
  {
    drawEntity();
    
    Soldier closest = this.closest(g.soldiers);
    
    this.rotateTo(closest.x, closest.y);
    
    this.attack(g);
    this.move();
  }
  
  public void attack(Game g)
  {
    Soldier closest = this.closest(g.soldiers);
    
    float dist = this.distance(closest);
    
    if (dist < 1){
      closest.attacked(damage);
    }
  }
  
  public void setMain()
  {
    main = true;
  }
  
  public boolean isAlive()
  {
    return health > 0;
  }
}
