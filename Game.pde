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
          
          if (zombie == mainZombie){
            if (this.zombies.size()==0){
              this.gameover = true;  
            }
            else {
              this.mainZombie = this.zombies.get((int)random(this.zombies.size()));
            }
          }
      }
    }
    
    Iterator<Bullet> bulletIter = bullets.iterator();
    //Update the bullets
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
    
    this.mainZombie = new Zombie(width/2, height/2, 0.0);
    
    zombies.add(mainZombie);
    zombies.add(new Zombie(width/2, height/3, 0.0));
  }

  public void advanceLevel()
  {
    gameLevel++;
    
    for (int i=0; i<gameLevel; i++)
    {      
      //TODO: Add zombies or soldiers
    }
  }
  

  public void drawBackground()
  {
    background.display();
  }

  void keyPressed()
  {
    println("x");
    
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
