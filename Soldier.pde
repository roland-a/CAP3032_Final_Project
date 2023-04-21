class Soldier extends ShootingEntity
{
  int damage;

  public Soldier(GamePos pos, int health)
  {
    super(.5, "soldier.png");

    this.pos = pos;
    this.angle = new Angle();

    this.radius = 10;
    this.speed = 3;

    this.health = health;
    this.maxBullets = 10;
    this.bulletCount = maxBullets;

    this.shootTime = .5;
    this.reloadTime = 4;

    this.damage = 10;
  }

  //Updates the soldier
  //Tries to shoot the closest zombie
  //If dead, then spawns a zombie in its place
  @Override
  public void update(Game g)
  {
    drawEntity();

    Zombie closest = g.zombies.closest(this.pos);

    if (closest != null)
    {
      reactTo(closest, g);
    }

    if (!this.isAlive())
    {
      Zombie z = new Zombie(this.pos, this.angle);
      g.zombies.add(z);
    }
  }

  //how to behave to the closest zombie
  void reactTo(Zombie closest, Game g) {
    this.rotateTo(closest);
    this.tryShoot(g);

    if (this.distanceTo(closest) < closest.radius+20) {
      this.move(false);
    } else {
      this.move(true);
    }
  }

  //Bullets made by soldiers can only hit zombies
  @Override
  boolean bulletInteract(Entity t) {
    if (t instanceof Zombie)
    {
      ((Zombie)t).damage(this.damage);
      return true;
    }
    return false;
  }
}
