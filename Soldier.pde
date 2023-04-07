class Soldier extends Entity
{
  //Maximum magazine size
  int maxBullets;
  //Current Bullet Count
  int bulletCount;

  //Reload Variables
  boolean reloading;
  float reloadTime;
  int reloadStart;
  
  //Shoot Variables
  boolean fired;
  int fireRatePerSecond;
  int shotStart;
  int health;

  public Soldier(float x, float y, float rot)
  {
    super(x, y, rot, 1, "soldier.png");

    health = 100; 
    maxBullets = 5;
    bulletCount = maxBullets;
    
    fireRatePerSecond = 2;
    reloadTime = 4.0;
  }

  public void update(Game g)
  {
    drawEntity();
    
    Zombie closest = this.closest(g.zombies);    
    this.rotateTo(closest.x, closest.y);

    if (bulletCount <= 0)
    {
      reload();
    }
    else
    {
      shoot(g.zombies, g.bullets);
    }
  }

  public void shoot(ArrayList<Zombie> zombies, ArrayList<Bullet> bullets)
  {
    if (fired) //Wait the firerate delay
    {    
      //Calculate how much time has allapsed since the start of the shot
      int timeAllapsedSinceShooting = millis() - shotStart;
      
      if (timeAllapsedSinceShooting > (1000/(fireRatePerSecond)))
      {  
        //The soldier can fire again
        fired = false;
      }    
    }
    else //Shoot a bullet
    {
      fired = true;
      
      //Make a bullet      
      Bullet b = new Bullet(this.x, this.y, 0.0);        
      b.rotateTo(this.closest(zombies));
      bullets.add(b);
      
      //Record when shot is fired
      shotStart = millis();
      
      bulletCount--;
    }
  }

  public void reload()
  {
    if (reloading) //If reload process has already started, wait the Reload Delay
    {
      //Calculate how much time has allapsed since the start of the reload
      float timeAllapsedSinceReloadStart = (millis() - reloadStart) / 1000; 
      
      //Reload is finished when allapsed time is greater than the reload time
      if (timeAllapsedSinceReloadStart >= reloadTime)
      {
        bulletCount = maxBullets;
        
        reloading = false;
      }
    }
    else //Begin the Reload
    {
      reloading = true;
      
      //Record when reload starts
      reloadStart = millis();
    }
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
