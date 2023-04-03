class Soldier extends Entity
{
  int maxBullets;
  int bullets;

  int reloadTime;

  int health;

  PImage soldierImage;

  public Soldier(float x, float y, int rot)
  {
    super(x, y, rot, 0);

    soldierImage = loadImage("soldier.png");

    health = 100; 
    maxBullets = 20;
    bullets = maxBullets;
    reloadTime = 5;
  }

  public void update()
  {
    drawEntity();

    if (bullets <= 0)
    {
      reload();
    }

    //shoot();
  }

  public Bullet shoot(ArrayList<Zombie> zombies)
  {
    Bullet b = new Bullet(this.x, this.y, 0.0);
    
    b.rotateTo(this.closest(zombies));
    
    return b;
  }

  public void reload()
  {
    //Add reload delay

    bullets = maxBullets;
  }

  public void attacked(int damage)
  {
    health -= damage;
  }

  public boolean isAlive()
  {
    return health > 0;
  }
}
