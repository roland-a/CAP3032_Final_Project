import java.util.Iterator; 

class Game
{
  int gameLevel;
  
  ArrayList<Soldier> soldiers;
  ArrayList<Zombie> zombies;
  ArrayList<Bullet> bullets;
  
  Zombie mainZombie;
  
  int x;
  int y;
  
  Background background = new Background();
  
  boolean gameover;

  public Game()
  {
    reset();
  } 

  float lastUpdate;
  public void update()
  {    
    drawBackground();
    
    if ((millis() - lastUpdate) /1000 > 3)
    {
      soldiers.add(new Soldier(random(0, width), random(0, height), 0.0));
      lastUpdate = millis();
    }
    
    //Update the soldiers
    Iterator<Soldier> soldierIter = soldiers.iterator();
    while (soldierIter.hasNext()) 
    {
      Soldier soldier = soldierIter.next();
      soldier.update(this);
      if (!soldier.isAlive()) 
      {
          zombies.add(new Zombie(soldier.x+20, soldier.y+20, 0));
          soldierIter.remove();
      }
    }

    //Update the zombies
    Iterator<Zombie> zombieIter = zombies.iterator();
    while (zombieIter.hasNext()) 
    {
      Zombie zombie = zombieIter.next();
      zombie.update(this);

      if (!zombie.isAlive()) 
      {
          zombieIter.remove();

          if (zombie == mainZombie)
          {
            chooseNewMainZombie();
          }
      }
    }
    
    //Update the bullets
    Iterator<Bullet> bulletIter = bullets.iterator();
    while (bulletIter.hasNext())
    {
      Bullet bullet = bulletIter.next();
      bullet.update(this);
      
      if (bullet.shouldBeRemoved())
      {
        bulletIter.remove();  
      }
    }
  
    if (zombies.size() <= 0) //Gameover if there are no more zombies
    {
      gameover = true;
    }
  }
  
  public void reset()
  {
    gameover = false;
    
    gameLevel = 0;
    
    soldiers = new ArrayList<>();
    zombies = new ArrayList<>();
    bullets = new ArrayList<>();
    
    //Add Initial Soldiers
    for (int i = 0; i < 30; i++)
    {
      soldiers.add(new Soldier(random(0, width), random(0, height), 0.0));
    }
    
    //Add initial Zombies
    for (int i = 0; i<50; i++)
    {
      zombies.add(new Zombie(random(0, width), random(0, height), 0.0));  
    }
    
    chooseNewMainZombie();
  }

  public void advanceLevel()
  {
    gameLevel++;
    
    for (int i=0; i<gameLevel; i++)
    {      
      //TODO: Add zombies or soldiers
    }
  }
  
  public void chooseNewMainZombie()
  {
    if (this.zombies.size()<=0)
    {
      this.gameover = true;  
    }
    else 
    {
      this.mainZombie = this.zombies.get((int)random(this.zombies.size()));
      this.mainZombie.setMain();
    }
  }
  
  public void drawBackground()
  {
    background.display();
  }
}
