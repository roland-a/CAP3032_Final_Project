class Game
{
  int gameLevel;
  
  ArrayList<Soldier> soldiers;
  ArrayList<Zombie> zombies;
  ArrayList<Bullet> bullets;
  
  int mainZombieIndex;
  
  int x;
  int y;
  
  PImage backgroundImage;
  
  boolean gameover;

  public Game()
  {
    //Temporary Background
    backgroundImage = loadImage("background.jpg");
    
    reset();
  } 

  public void update()
  {    
    drawBackground();
    
    //Update the soldiers
    for (Soldier soldier : soldiers)
    {
      soldier.update(this);
    }

    //Update the zombies
    for (Zombie zombie : zombies)
    {
      zombie.update(this);
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
    soldiers.add(new Soldier(100, 100, 0.0));
    
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
    //TEMPORARY BACKGROUND
    background(backgroundImage);
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
