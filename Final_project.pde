Background background;

Menu menu;
LevelMenu levelMenu;

Game currGame;

boolean inMainMenu = true;

int currentY = 0;
int targetY = 0;

void setup()
{
  size(1440, 810);
  frameRate(60);

  background = new Background();
  menu = new Menu(0, 0);
  levelMenu = new LevelMenu(0, -height);
};

Game makeLevel1()
{
  return new Game(background){
    int maxZombies = 2;

    {
      this.secsBetweenUpdates = 1;

      while (this.zombies.size()<2)
      {
        this.zombies.add(randomZombie());
      }
      while (this.soldiers.size()<1)
      {
        this.soldiers.add(
          new Soldier(randomScreenPos(), 5)
        );
      }
    }

    @Override
    void doPeriodicUpdate()
    {
      if (this.maxZombies<this.zombies.size())
      {
        this.maxZombies = this.zombies.size();
      }

      int soldierCount = this.maxZombies/2;
      int soldierHealth = 5 + this.zombies.size()*2;

      while (this.soldiers.size()<soldierCount)
      {
        this.soldiers.add(
          new Soldier(randomScreenPos(), soldierHealth)
        );
      }
    }
  };
}

Game makeLevel2()
{
  return new Game(background){
    //constructor
    {
      this.secsBetweenUpdates = 5;

      while (this.zombies.size()<20)
      {
        this.zombies.add(randomZombie());
      }
      while (this.soldiers.size()<20)
      {
        this.soldiers.add(
          new Soldier(randomScreenPos(), 20)
        );
      }
    }

    @Override
    void doPeriodicUpdate()
    {
      int soldierCount = 20+this.started.secsPassed()/3;
      int soldierHealth = 10+this.started.secsPassed()/3;
      
      while (this.soldiers.size()<soldierCount)
      {
        this.soldiers.add(
          new Soldier(randomScreenPos(), soldierHealth)
        );
      }
    }
  };
}

void draw()
{
  background.display();

  if (currGame != null) {
    currGame.update();
  } 
  else 
  {
    if (currentY < targetY)
    {
      moveScreenDown();
    } else if (currentY > targetY)
    {
      moveScreenUp();
    }
    menu.display();
    levelMenu.display();
  }
}

void mouseClicked()
{
  if (currGame != null) return;
  
  //Main Menu Buttons
  if (inMainMenu && menu.startButton.intersects(mouseX, mouseY))
  {
    inMainMenu = false;

    targetY = height;
  }
  if (inMainMenu && menu.quitButton.intersects(mouseX, mouseY))
  {
    exit();
  }

  //Level Menu Buttons
  if (!inMainMenu && levelMenu.backButton.intersects(mouseX, mouseY))
  {
    inMainMenu = true;

    targetY = 0;
  }

  if (!inMainMenu && levelMenu.level1.intersects(mouseX, mouseY))
  {
    currGame = makeLevel1();
  }

  if (!inMainMenu && levelMenu.level2.intersects(mouseX, mouseY))
  {
    currGame = makeLevel2();
  }
}

void moveScreenUp()
{
  int moveAmount = 10;
  currentY -= moveAmount;
  menu.moveUp(moveAmount);
  levelMenu.moveUp(moveAmount);
  background.move(-2);
}

void moveScreenDown()
{
  int moveAmount = 10;
  currentY += moveAmount;
  menu.moveDown(moveAmount);
  levelMenu.moveDown(moveAmount);
  background.move(2);
}
