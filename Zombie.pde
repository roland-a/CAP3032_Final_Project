class Zombie extends Entity
{
  int health;
  
  Zombie(float x, float y, float rot)
  {
    super(x, y, rot, 2.0);
    
    this.health = 3;
  }
  
  public void updateIfMain(Game g)
  {
    this.rot = atan2(g.x, g.y);
    
    this.attack(g);
    this.move();
  }
  
  public void updateIfHoard(Game g)
  {
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
      closest.health -= 1;
    }
  }
}
