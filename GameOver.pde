class GameOver
{
  
  int originX, originY;
  
  Button retryButton, quitButton;
  
  public GameOver(int newX, int newY)
  {
    originX = newX;
    originY = newY;
    
    retryButton = new Button("RETRY", originX + width/2 - 300, originY + height - 200, color(0));
    quitButton = new Button("QUIT", originX + width/2 + 300, originY + height - 200, color(150, 0, 0));
  }
  
  public void display()
  {
    //Draw background rectangle
    noStroke();
    rectMode(CENTER);
    fill(0, 95);
    rect(originX + width/2, originY + height/2, width-200, height-200, 30);
    
    //Draw buttons
    retryButton.display();
    quitButton.display();
  }
  
  public void moveDown(int moveAmount)
  {
    originY += moveAmount;
    
    updateButtons();
  }
  
  public void moveUp(int moveAmount)
  {
    originY -= moveAmount;
    
    updateButtons();
  }
  
  public void setOrigin(int newX, int newY)
  {
    originX = newX;
    originY = newY;
    
    updateButtons();
  }
  
  public void updateButtons()
  {
    retryButton.updateLoc(width/2 - 300, originY + height-200);
    quitButton.updateLoc(width/2 + 300, originY + height-200);
  }
}
