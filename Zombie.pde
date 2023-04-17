class Zombie extends ShootingEntity
{
  int damage;
  
  boolean main;
  
  Zombie(GamePos pos, Angle angle)
  {
    super(.5, "zombie.png");
    
    this.pos = pos;
    this.angle=angle;
    this.speed = 4;
    
    this.maxBullets = 10;
    this.bulletCount = this.maxBullets;
    
    this.fireRatePerSecond = 2;
    this.reloadTime = 4;
    
    this.health = 50;
    this.damage = 1;
    
    this.main = false;
  }
  
  public void update(Game g)
  {
    drawEntity();
    
    if (main)
    {
      this.mainUpdate(g);
    }
    else
    {
      this.hordeUpdate(g);
    }
  }
  
  boolean bulletCanHit(Entity t){
    return t instanceof Soldier || t instanceof Zombie;
  }
  
  public void mainUpdate(Game g)
  {
    ScreenPos mousePos = getMousePos();
    
    if (this.distance(mousePos)>5){
      this.rotateTo(mousePos);
      this.move(this.angle, this.speed, g.zombies, g.soldiers);
    }
    
    if (mousePressed && mouseButton == LEFT){
      println(this.bulletCount);
      this.shoot(g);  
    }
    
    Soldier closest = closest(g.soldiers);
    if (closest != null){
      this.attack(closest);  
    }
    
  }
  
  
  public void hordeUpdate(Game g)
  {
    if (mousePressed && mouseButton == RIGHT && this.distance(getMousePos()) < 500)
    {
      this.rotateTo(getMousePos());
      this.move(this.angle, this.speed, g.zombies, g.soldiers);
    }
    else {
      Soldier closest = this.closest(g.soldiers);
      if (closest == null) return;
    
      this.rotateTo(closest);
      this.move(this.angle, this.speed, g.zombies, g.soldiers);
      
      this.attack(closest);
    }
  }
  
  public void attack(Soldier closest)
  {
    float dist = this.distance(closest);
  
    if (dist < 30){
      closest.damage(damage);
    }
  }
  
  public void setMain()
  {
    tintEntity(255, 50, 50);
    this.main = true;
  }
  
  void move(Angle angle, float speed, ArrayList<Zombie> zombies, ArrayList<Soldier> soldiers)
  {
    GamePos proj = this.pos.move(angle, speed);
    
    if (proj.x < 20 && proj.x > width-20) return;
    if (proj.y > height) return;
    
    ArrayList<Zombie> toMove = new ArrayList();
    for (Zombie z: zombies){
      if (z == this) continue;
      
      float d1 = this.pos.distanceTo(z.pos);
      float d2 = proj.distanceTo(z.pos);
      
      if (d1>d2 && d2 < 30){
          toMove.add(z);
      }
    }
    
    for (Soldier s: soldiers){
      float d1 = this.pos.distanceTo(s.pos);
      float d2 = proj.distanceTo(s.pos);
      
      if (d1>d2 && d2 < 30){
        return;
      }
    }
    
    for (Zombie z: toMove){
      z.move(angle, speed/(toMove.size()+1), zombies, soldiers);
    }
    this.pos = this.pos.move(angle, speed/(toMove.size()+1));
  }
}
