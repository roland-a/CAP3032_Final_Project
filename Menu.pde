class Menu
{
  PImage titleImage;
  
  int originX, originY;
  
  Button startButton, quitButton;
  
  //Constructor of the Menu that initializes the location of the menu screen and the locations of the buttons
  public Menu(int newX, int newY)
  {
    titleImage = loadImage("title.png");
    
    originX = newX;
    originY = newY;
    
    startButton = new Button("START", originX + width/2 - 300, originY + height - 200, color(0, 150, 0));
    quitButton = new Button("QUIT", originX + width/2 + 300, originY + height - 200, color(150, 0, 0));
  }
  
  //Displays a backing rectangle and calls the buttons' display methods
  public void display()
  {
    //Draw background rectangle
    noStroke();
    rectMode(CENTER);
    fill(0, 95);
    rect(originX + width/2, originY + height/2, width-200, height-200, 30);
    
    //Draw title image
    imageMode(CENTER);
    image(titleImage, originX+width/2, originY + height/2 - 100);
    
    //Draw buttons
    startButton.display();
    quitButton.display();
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
    startButton.updateLoc(width/2 - 300, originY + height-200);
    quitButton.updateLoc(width/2 + 300, originY + height-200);
  }
}
