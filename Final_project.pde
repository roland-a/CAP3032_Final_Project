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

void keyPressed()
{
  game.playerKeyboard();
}
