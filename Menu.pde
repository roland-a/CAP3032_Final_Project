class Menu
{
  PImage titleImage;
  
  int originX, originY;
  
  Button startButton, quitButton;
  
  public Menu(int newX, int newY)
  {
    titleImage = loadImage("title.png");
    
    originX = newX;
    originY = newY;
    
    startButton = new Button("START", width/2 - 300, height - 200, color(0, 150, 0));
    quitButton = new Button("QUIT", width/2 + 300, height - 200, color(150, 0, 0));
  }
  
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
  
  public void moveDown(int moveAmount)
  {
    originY += moveAmount;
    startButton.updateLoc(width/2 - 300, originY + height-200);
    quitButton.updateLoc(width/2 + 300, originY + height-200);
  }
  
  public void moveUp(int moveAmount)
  {
    originY -= moveAmount;
    startButton.updateLoc(width/2 - 300, originY + height-200);
    quitButton.updateLoc(width/2 + 300, originY + height-200);
  }
}
