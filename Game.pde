abstract class Game
{
  Background background;
  
  EntityList<Soldier> soldiers = new EntityList<>();
  EntityList<Zombie> zombies = new EntityList<>();
  EntityList<Bullet> bullets = new EntityList<>();
  Zombie mainZombie;

  TimeStamp started;
  TimeStamp lastUpdated;
  
  float secsBetweenUpdates;
  
  Game(Background background)
  {
    this.started = now();
    this.lastUpdated = now();
    
    this.background = background;
  }

  abstract void doPeriodicUpdate();
  
  //runs an update every loop
  void update()
  {    
    background.display();

    soldiers.update(this);
    zombies.update(this);
    bullets.update(this);
    
    if (this.mainZombie==null || (!mainZombie.isAlive() && this.zombies.size()>0)){
      this.mainZombie = this.zombies.getRandom();
      this.mainZombie.setMain();
    }
    
    if (this.lastUpdated.hasSecsPassed(secsBetweenUpdates)){
      doPeriodicUpdate();
      this.lastUpdated = now();
    }
  }

  public boolean isGameOver(){
    return zombies.size()==0;
  }
}
