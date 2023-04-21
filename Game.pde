import java.util.Iterator; 

abstract class Game
{
  Background background = new Background();
  
  EntityList<Soldier> soldiers = new EntityList<>();
  EntityList<Zombie> zombies = new EntityList<>();
  EntityList<Bullet> bullets = new EntityList<>();
  Zombie mainZombie;

  Time started;
  Time lastUpdated;
  
  int secsBetweenUpdates;
  
  
  Game()
  {
    this.started = now();
    this.lastUpdated = now();
    
  }

  abstract void doUpdate();
  
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
      doUpdate();
      this.lastUpdated = now();
    }
  }

  public boolean isGameOver(){
    return zombies.size()==0;
  }
}
