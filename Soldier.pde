class Soldier extends Entity
{
  int maxBullets;
  int bulletCount;

  //Reload Variables
  boolean reloading;
  int reloadTime;
  int reloadStartMinute;
  int reloadStartSecond;
  
  //Shoot Variables
  boolean fired;
  int fireRate;
  int shotStartMinute;
  int shotStartSecond;

  int health;

  public Soldier(float x, float y, int rot)
  {
    super(x, y, rot, 0, "soldier.png");

    health = 100; 
    maxBullets = 20;
    bulletCount = maxBullets;
    
    fireRate = 1;
    reloadTime = 5;
  }

  public void update(Game g)
  {
    drawEntity();

    if (bulletCount <= 0)
    {
      reload();
    }
    
    shoot(g.zombies, g.bullets);
  }

  public void shoot(ArrayList<Zombie> zombies, ArrayList<Bullet> bullets)
  {
    if (fired) //Wait until the 
    {    
      //Calculate how much time has allapsed since the start of the shot
      int timeAllapsedSinceShooting = minute() > shotStartMinute ? (60 - shotStartSecond) + second() : second() - shotStartSecond;
      
      if (timeAllapsedSinceShooting > fireRate)
      {  
        //The soldier can fire again
        fired = false;
      }    
    }
    else
    {
      fired = true;
      
      //Make a bullet      
      Bullet b = new Bullet(this.x, this.y, 0.0);        
      b.rotateTo(this.closest(zombies));
      bullets.add(b);
      
      //Record when shot is fired
      shotStartMinute = minute();
      shotStartSecond = second();
      
      bulletCount--;
    }
  }

  public void reload()
  {
    //Reload Delay
    if (reloading)
    {
      //Calculate how much time has allapsed since the start of the reload
      int timeAllapsedSinceReloadStart = minute() > reloadStartMinute ? (60 - reloadStartSecond) + second() : second() - reloadStartSecond; 
      
      //Reload is finished when allapsed time is greater than the reload time
      if (timeAllapsedSinceReloadStart > reloadTime)
      {
        bulletCount = maxBullets;
        
        reloading = false;
      }
    }
    else
    {
      reloading = true;
      
      //Record when reload starts
      reloadStartMinute = minute();
      reloadStartSecond = second();
    }
  }

  public void attacked(int damage)
  {
    health -= damage;
  }

  public boolean isAlive()
  {
    return health > 0;
  }
}
