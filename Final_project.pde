Background background;

Menu menu;
LevelMenu levelMenu;

Game level1;

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
  
  level1 = new Game(background){
    int maxZombies = 0;
    
    {
      this.secsBetweenUpdates = 1;  
      
      while (this.zombies.size()<1)
      {
        this.zombies.add(randomZombie());
      }
      while (this.soldiers.size()<1)
      {
        this.soldiers.add(
          new Soldier(randomScreenPos())
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
      if (soldierCount == 0)
      {
          soldierCount = 1;
      }
      
      int soldierHealth = 5 + this.zombies.size()*2;
      
      while (this.soldiers.size()<soldierCount)
      {
        this.soldiers.add(
          new Soldier(randomScreenPos())
          {
            {
              this.health = soldierHealth;
            }
          }
        );
      }
    }
};
  
}

void draw()
{
  if (currentY < targetY)
  {
    moveScreenDown();
  }
  else if (currentY > targetY)
  {
    moveScreenUp();
  }
  
  background.display();  
  menu.display();
  levelMenu.display();
  //game.update();
}

void mouseClicked()
{
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
