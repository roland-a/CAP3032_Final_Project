import processing.sound.*;

Background background;

//User Interface Menus
Menu mainMenu;
LevelMenu levelMenu;
GameOver gameoverMenu;

Game currGame;

SoundFile music;

int menuState = 0;

int currentY = 0;
int targetY = 0;

//Sets up the global variables of the game such as the background, menus, and background music
void setup()
{
  size(1440, 810);
  frameRate(60);
  
  background = new Background();
  
  //Menus
  mainMenu = new Menu(0, 0);
  levelMenu = new LevelMenu(0, -height);
  gameoverMenu = new GameOver(0, height);
  
  music = new SoundFile(this, "music.mp3");
  music.loop();
}

//Calls the display methods of the game objects such as the menus
//Also updates the scrolling effect of the screen
void draw()
{
  background.display();  
  
  if (currGame != null && !currGame.isGameOver()){
    currGame.update();
  }
  else {
    if (currGame != null && currGame.isGameOver())
    {
      currentY = -height;
      targetY = -height;
      
      levelMenu.setOrigin(0, -height * 2);
      mainMenu.setOrigin(0, -height);
      gameoverMenu.setOrigin(0, 0);
      gameoverMenu.score = currGame.getScore();
      
      menuState = 2;
      
      currGame = null;
    }    
    
    if (currentY < targetY)
    {
      moveScreenDown();
    }
    else if (currentY > targetY)
    {
      moveScreenUp();
    }
    
    mainMenu.display();
    levelMenu.display();
    gameoverMenu.display();
  }
}

//Update the game when the mouse is clicked
//If the player is not in a game check for intersections with the menu buttons
void mouseClicked()
{
  if (currGame == null)
  {
    //Main Menu Buttons
    if (menuState == 0 && mainMenu.startButton.intersects(mouseX, mouseY))
    {
      menuState = 1;
      
      targetY = height;
    }  
    if (menuState == 0 && mainMenu.quitButton.intersects(mouseX, mouseY))
    {
      exit();
    }
    
    //Level Menu Buttons
    if (menuState == 1 && levelMenu.backButton.intersects(mouseX, mouseY))
    {
      menuState = 0;
      
      targetY = 0;
    }  
    //Level Menu Buttons
    if (menuState == 1 && levelMenu.level1.intersects(mouseX, mouseY))
    {
      currGame = makeLevel1();
    }
    if (menuState == 1 && levelMenu.level2.intersects(mouseX, mouseY))
    {
      currGame = makeLevel2();
    }
    
    //Game Over Buttons
    if (menuState == 2 && gameoverMenu.retryButton.intersects(mouseX, mouseY))
    {
      currGame = makeLevel1();
    }  
    if (menuState == 2 && gameoverMenu.quitButton.intersects(mouseX, mouseY))
    {
      menuState = 0;
      
      targetY = 0;
    }
  }
}

//Scrolls the menu screens and the background up to create the rolling effect
void moveScreenUp()
{
  int moveAmount = 30;
  currentY -= moveAmount;
  mainMenu.moveUp(moveAmount);
  levelMenu.moveUp(moveAmount);
  gameoverMenu.moveUp(moveAmount);
  background.move(-2);
}

//Scrolls the menu screens and the background down to create the rolling effect
void moveScreenDown()
{
  int moveAmount = 30;
  currentY += moveAmount;
  mainMenu.moveDown(moveAmount);
  levelMenu.moveDown(moveAmount);
  gameoverMenu.moveDown(moveAmount);
  background.move(2);
}

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
    
    @Override()
    int getScore(){
      return this.maxZombies;
    }
  };
}

Game makeLevel2()
{
  return new Game(background){
    //constructor
    {
      this.secsBetweenUpdates = 2;

      while (this.zombies.size()<10)
      {
        this.zombies.add(randomZombie());
      }
      while (this.soldiers.size()<10)
      {
        this.soldiers.add(
          new Soldier(randomScreenPos(), 20)
        );
      }
    }

    @Override
    void doPeriodicUpdate()
    {
      int soldierCount = this.started.secsPassed()/5;
      int health = 10 +this.started.secsPassed();

      while (this.soldiers.size()<soldierCount)
      {
        this.soldiers.add(
          new Soldier(randomScreenPos(), health)
        );
      }
    }
    
    @Override()
    int getScore(){
      return this.started.secsPassed();
    }
  };
}
