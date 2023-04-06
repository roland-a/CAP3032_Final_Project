class Zombie extends Entity
{
  int health;
  int damage;
  
  Zombie(float x, float y, float rot)
  {
    super(x, y, rot, 2.0, "zombie.png");
    
    this.health = 3;
    damage = 10;
  }
  
  public void updateIfMain(Game g)
  {
    drawEntity();
    
    this.rot = atan2(g.x, g.y);
    
    this.attack(g);
    this.move();
  }
  
  public void updateIfHoard(Game g)
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
}
