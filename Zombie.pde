class Zombie extends Entity
{
  int health;
  int damage;
  
  boolean main;
  
  Zombie(float x, float y, float rot)
  {
    super(x, y, rot, 4.0, "zombie.png");
    
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
    
    this.rotateTo(mouseX, mouseY);
    
    this.attack(g);
    
    this.move(g.zombies, g.soldiers);
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
    
    if (mousePressed && mouseButton == RIGHT)
    {
      if (dist(x, y, mouseX, mouseY) < 200)
      {
        this.rotateTo(mouseX, mouseY);
        this.move(g.zombies, g.soldiers);
      }
    }
    else {
      Soldier closest = this.closest(g.soldiers);
    
      this.rotateTo(closest);
    
      this.attack(g);
      if (closest != null)
      {
        this.move(g.zombies, g.soldiers);
      }
    }
  }
  
  public void attack(Game g)
  {
    Soldier closest = this.closest(g.soldiers);
    
    if (closest != null)
    {
      float dist = this.distance(closest);
    
      if (dist < 32){
        closest.damaged(damage);
      }
    }
  }
  
  public void damaged(float damage)
  {
    health -= damage;
  }
  
  public void setMain()
  {
    tintEntity(255, 50, 50);
    main = true;
  }
  
  public boolean isAlive()
  {
    return health > 0;
  }
  
  void move(ArrayList<Zombie> zombies, ArrayList<Soldier> soldiers){
    move(this.rot, this.speed, zombies, soldiers);
  }
  
  void move(float rot, float speed, ArrayList<Zombie> zombies, ArrayList<Soldier> soldiers)
  {
    float projX = this.x + cos(rot) * speed;
    float projY = this.y + sin(rot) * speed;
    
    ArrayList<Zombie> toMove = new ArrayList();
    for (Zombie z: zombies){
      if (z == this) continue;
      
      float d1 = dist(this.x, this.y, z.x, z.y);
      float d2 = dist(projX, projY, z.x, z.y);
      

      if (d1>d2 && d2 < 30){
          toMove.add(z);
      }
    }
    
    for (Soldier s: soldiers){
      float d1 = dist(this.x, this.y, s.x, s.y);
      float d2 = dist(projX, projY, s.x, s.y);
      
      if (d1>d2 && d2 < 30){
        return;
      }
    }
    
    for (Zombie z: toMove){
      z.move(rot, speed/(toMove.size()+1), zombies, soldiers);
    }
    this.move(rot, speed/(toMove.size()+1));
  }
}
