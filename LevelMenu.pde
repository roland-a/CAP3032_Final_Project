
class LevelMenu
{
  //What the menu state thinks is the origin
  int originX, originY;
  
  Button level1, level2, backButton;
  
  //Constructor of the LevelMenu that initializes the location of the gameover screen and the locations of the buttons
  public LevelMenu(int newX, int newY)
  {
    originX = newX;
    originY = newY;
    
    level1 = new Button("Level 1", originX + width/2 - 300, originY + height/2 - 100, color(0));
    level2 = new Button("Level 2", originX + width/2 + 300, originY + height/2 - 100, color(0));
    backButton = new Button("BACK", originX + width - 300, originY + height-200, color(150, 0, 0));
  }
  
  //Displays a backing rectangle and calls the buttons' display methods
  public void display()
  {
    noStroke();
    rectMode(CENTER);
    fill(0, 95);
    rect(originX + width/2, originY + height/2, width-200, height-200, 30);
    
    level1.display();
    level2.display();
    backButton.display();
  }
  
  //Scrolls the screen down
  public void moveDown(int moveAmount)
  {
    originY += moveAmount;
    
    updateButtons();
  }
  
  //Scrolls the screen up
  public void moveUp(int moveAmount)
  {
    originY -= moveAmount;
    
    updateButtons();
  }
  
  //Sets the origin of the screen
  public void setOrigin(int newX, int newY)
  {
    originX = newX;
    originY = newY;
    
    updateButtons();
  }
  
  //Updates the locations of the buttons
  public void updateButtons()
  {
    level1.updateLoc(originX + width/2 - 300, originY + height/2 - 100);
    level2.updateLoc(originX + width/2 + 300, originY + height/2 - 100);
    backButton.updateLoc(originX + width - 300, originY + height-200);
  }
}
