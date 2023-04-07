class Zombie extends Entity
{
  int health;
  int damage;
  
  boolean main;
  
  Zombie(float x, float y, float rot)
  {
    super(x, y, rot, 2.0, "zombie.png");
    
    this.health = 20;
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
    
    this.rotateTo(mouseX, mouseY);
    
    this.attack(g);
  }
  
  public void mainMove()
  {
    if (key == 'w')
    {
      this.y -= 5;
    }
    
    if (key == 'a')
    {
      this.x -= 5;
    }
    
    if (key == 's')
    {
      this.y += 5;
    }
    
    if (key == 'd')
    {
      this.x += 5;
    }
  }
  
  public void hordeUpdate(Game g)
  {
    drawEntity();
    
    Soldier closest = this.closest(g.soldiers);
    
    this.rotateTo(closest);
    
    this.attack(g);
    if (closest != null)
    {
      this.move();
    }
  }
  
  public void attack(Game g)
  {
    Soldier closest = this.closest(g.soldiers);
    
    if (closest != null)
    {
      float dist = this.distance(closest);
    
      if (dist < 1){
        closest.damaged(damage);
      }
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
