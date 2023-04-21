Background background;

Menu menu;
LevelMenu levelMenu;
Game game;

boolean inMainMenu = true;
boolean gameStarted = false;

int currentY = 0;
int targetY = 0;

void setup()
{
  size(1440, 810);
  frameRate(60);
  
  background = new Background();
  menu = new Menu(0, 0);
  levelMenu = new LevelMenu(0, -height);
  game = new Game();
}

void draw()
{
  if (!gameStarted)
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
  }
  else
  {
    game.update();
  }
}

void mouseClicked()
{
  if (!gameStarted)
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
    if (!inMainMenu && levelMenu.level1.intersects(mouseX, mouseY))
    {
      //TODO: starts level1 game mode
    }
    if (!inMainMenu && levelMenu.level2.intersects(mouseX, mouseY))
    {
      //TODO: starts level2 game mode
    }
  }
}

void moveScreenUp()
{
  int moveAmount = 10;
  currentY -= moveAmount;
  menu.moveUp(moveAmount);
  levelMenu.moveUp(moveAmount);
  background.y-=2;
}

void moveScreenDown()
{
  int moveAmount = 10;
  currentY += moveAmount;
  menu.moveDown(moveAmount);
  levelMenu.moveDown(moveAmount);
  background.y+=2;
}
