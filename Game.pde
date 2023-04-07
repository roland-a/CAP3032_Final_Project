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

  public void update()
  {    
    drawBackground();
    
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
    
    //TODO: choose initial soldiers and zombies
    soldiers.add(new Soldier(400, 400, 0.0));
    
    //Add Soldiers
    for (int zombieX = 100; zombieX < width; zombieX += 100)
    {
      zombies.add(new Zombie(zombieX, height/3, 0.0));  
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
  
  public void playerKeyboard()
  {
    mainZombie.mainMove();
  }
}
