Game game;

void setup()
{
  size(1440, 810);
  
  game = new Game();
}

void draw()
{
  game.update();
}

void keyPressed(){
  game.x = 0;
  game.y = 0;
  
  if (key == 'w'){
    game.y -= 1;  
  }
  if (key == 's'){
    game.y += 1;
  }
  if (key == 'a'){
    game.x -= 1;  
  }
  if (key == 'd'){
    game.x += 1;
  }
}
