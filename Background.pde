class Background{
  final int lineSize = 20;
  final int roadSize = 400;
  final int center = 500;
  final int edge1Size = roadSize+50;
  final int edge2Size = edge1Size+50;
  
  final color lineColor = color(200,200,200);
  final color roadColor = color(100,100,100);
  final color edge1Color = color(80,80,80);
  final color edge2Color = color(100,100,50);
  
  final color sand1Color = color(150,150,0);
  final color sand2Color = color(100,150,0);
  
  int y = 0;
  
  private int bufferY = 0;
  private color[][] buffer;
  
  
  Background(){
    buffer = new color[pixelWidth][pixelHeight];
  }
  
  private void moveUp(){
    this.bufferY += 1;  
    
    for (int x = 0; x < pixelWidth; x++)
    {
      for (int y = pixelHeight-1; y >=0; y--)
      {
        if (y == 0)
        {
          buffer[x][y] = 0;
        }
        else {
          buffer[x][y] = buffer[x][y-1];
        }
      }
    }
  }
    
  private void moveDown(){
    this.bufferY -= 1;  
    
    for (int x = 0; x < pixelWidth; x++)
    {
      for (int y = 0; y < pixelHeight; y++)
      {
        if (y == pixelHeight-1)
        {
          buffer[x][y] = 0;
        }
        else {
          buffer[x][y] = buffer[x][y+1];
        }
      }
    }
  }
  
  private void display()
  {
    while (bufferY != y){
      if (y > bufferY){
        moveUp();  
      }
      else {
        moveDown();  
      }
    }
    
    
    for (int x = 0; x < pixelWidth; x++)
    {
      for (int y = 0; y < pixelHeight; y++)
      {
        if (buffer[x][y] == 0)
        {
          buffer[x][y] = getColor(x,y+this.y);  
        }
        set(x,y, buffer[x][y]);
      }
    }
  }
  
  private boolean inBlob(int x, int y, float scale, float value){
      return noise(x/scale, y/scale) < value;  
  }
  
  private boolean inLayer(int x, int size){
     return x > center-size/2 && x < center+size/2; 
  }
  
  private float distFromEdge(int x, int size){
    return abs(size/2-abs(x-center));
  }
  
  private color getColor(int x, int y){
    if (
      inLayer(x, lineSize) && 
      inBlob(x,y,20,.6)
    ){
      return lineColor;
    }
    
    if (
      inLayer(x, roadSize) &&  
      inBlob(x,y,20, distFromEdge(x, roadSize)*.02)
    ){
      return roadColor;
    }
    
    if (
      inLayer(x, edge1Size) && 
      inBlob(x,y,20, distFromEdge(x, edge1Size)*.02)
    ){
      return edge1Color;
    }
    
    if (
      inLayer(x, edge2Size) &&  
      inBlob(x,y,20, distFromEdge(x, edge2Size)*.02)
    ){
      return edge2Color;
    }
    
    if (inBlob(x,y,50,.5)){
      return sand1Color;
    }
    return sand2Color;
  }
}
