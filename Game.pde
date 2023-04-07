import java.util.Iterator; 

class Game
{
  int gameLevel;
  
  ArrayList<Soldier> soldiers;
  ArrayList<Zombie> zombies;
  ArrayList<Bullet> bullets;
  
  int mainZombieIndex;
  
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
      }
    }
    
    //Update the bullets
    for (Bullet bullet : bullets)
    {
      bullet.update(this);
    }
    
    //If the main zombie is dead, choose a new main zombie
    if (!zombies.get(mainZombieIndex).isAlive() && zombies.size() > 0)
    {
      chooseNewMainZombie();
    }
    else if (zombies.size() <= 0) //Gameover if there are no more zombies
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
    
    zombies.add(new Zombie(width/2, height/2, 0.0));
    mainZombieIndex = 0;
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
    mainZombieIndex = (int) random(zombies.size());
    zombies.get(mainZombieIndex).setMain();    
  }

  public void drawBackground()
  {
    background.display();
  }

  void keyPressed()
  {
    game.x = 0;
    game.y = 0;

    if (key == 'w')
    {
      game.y -= 1;
    }
    if (key == 's')
    {
      game.y += 1;
    }
    if (key == 'a')
    {
      game.x -= 1;
    }
    if (key == 'd')
    {
      game.x += 1;
    }
  }
}
