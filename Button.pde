class Button
{
  String text;
  int x, y;
  int buttonW = 200;
  int buttonH = 100;
  color buttonCol;
  
  public Button(String buttonText, int newX, int newY, color newColor)
  {
    text = buttonText;
    x = newX;
    y = newY;
    buttonCol = newColor;
  }
  
  public void display()
  {
    noStroke();
    rectMode(CENTER);
    fill(buttonCol);
    rect(x, y, buttonW, buttonH);
    
    textSize(30);
    textAlign(CENTER, CENTER);
    fill(255);
    text(text, x, y);
  }
  
  public boolean intersects(int xLoc, int yLoc)
  {
    boolean xIntersects = (x-buttonW/2 <= xLoc) && (xLoc <= x+buttonW/2);
    boolean yIntersects = (y-buttonW/2 <= yLoc) && (yLoc <= y+buttonW/2);
    
    return xIntersects && yIntersects;
  }
  
  public void updateLoc(int newX, int newY)
  {
    x = newX;
    y = newY;
  }
}
