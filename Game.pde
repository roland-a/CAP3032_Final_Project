class Game
{
  ArrayList<Soldier> soldiers = new ArrayList<>();
  ArrayList<Zombie> zombies = new ArrayList<>();
  ArrayList<Bullet> bullets = new ArrayList<>();
  
  Zombie main = new Zombie(width/2, height/2, 0);
  
  int x;
  int y;
  
  Background background;

  public Game()
  {
    background = new Background();
  } 

  public void update()
  {
    //Update the soldiers
    for (Soldier soldier : soldiers)
    {
      soldier.update(this);
    }

    //Update the zombies
    for (Zombie zombie : zombies)
    {
      zombie.updateIfHoard(this);
    }
    
    main.updateIfMain(this);
  }

  public void addSoldier()
  {
    soldiers.add(new Soldier(100,100,0));
  }

  public void addZombie()
  {
  }

  public void drawBackground()
  {

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
