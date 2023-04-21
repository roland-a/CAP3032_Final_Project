class Background{
  //where the center of the road should be 
  final int center = 600;
  
  //width of the road divider
  final int dividerSize = 10;
  
  //width of the road
  final int roadSize = 200;

  //width of the first outer edge of the road
  final int edge1Size = 50;
  
  //width of the second outer edge from the road
  final int edge2Size = 50;
  
  //color of the road divider
  final color dividerColor = color(200,200,200);
  
  //color of the road
  final color roadColor = color(100,100,100);
  
  //color the first outer road edge
  final color edge1Color = color(80,80,80);
  
  //color of second outer road edge
  final color edge2Color = color(100,100,50);
  
  final color grass1Color = color(150,150,0);
  final color grass2Color = color(100,150,0);
  
  private color[][] buffer;
  
  private int y;
  
  Background(){
    buffer = new color[pixelWidth][pixelHeight];
  }
  
  //moves the background up or down
  void move(int y){
    if (y > 0){
      for (int i = 0; i < y; i++){
        this.moveUp();
      }
    }
    if (y < 0){
      for (int i = 0; i < -y; i++){
        this.moveDown();
      }
    }
  }
  
  
  //shifts the background upwards
  private void moveUp(){
    this.y++;
    
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
    
  //shifts the buffer downward
  private void moveDown(){
    this.y--;
    
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
  
  
  //Returns whether the current pixel is inside a noise blob
  private boolean inBlob(int x, int y, float scale, float value){
      return noise(x/scale, y/scale) < value;  
  }
  
  //Returns whether the current pixel inside a vertical layer
  //A layer can represent a road divider, road, curb, ect
  private boolean inLayer(int x, int size){
     return x > center-size/2 && x < center+size/2; 
  }
  
  //returns the distance from the edge of a layer
  private float distFromEdge(int x, int size){
    return abs(size/2-abs(x-center));
  }
  
  //returns the color at the pixel location
  private color getColor(int x, int y){
    if (
      inLayer(x, dividerSize) && 
      inBlob(x,y,20,.5)
    ){
      return dividerColor;
    }
    
    if (
      inLayer(x, roadSize) &&  
      inBlob(x,y,20, distFromEdge(x, roadSize)*.02)
    ){
      return roadColor;
    }
    
    if (
      inLayer(x, roadSize+edge1Size) && 
      inBlob(x,y,20, distFromEdge(x, roadSize+edge1Size)*.02)
    ){
      return edge1Color;
    }
    
    if (
      inLayer(x, roadSize+edge1Size+edge2Size) &&  
      inBlob(x,y,20, distFromEdge(x, roadSize+edge1Size+edge2Size)*.02)
    ){
      return edge2Color;
    }
    
    if (inBlob(x,y,50,.5)){
      return grass1Color;
    }
    return grass2Color;
  }
}
