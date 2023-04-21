class Soldier extends ShootingEntity
{
  int damage;

  public Soldier(GamePos pos)
  {
    super(.5, "soldier.png");

    this.pos = pos;
    this.angle = new Angle();

    this.radius = 10;
    this.speed = 3;

    this.health = 5;
    this.maxBullets = 10;
    this.bulletCount = maxBullets;

    this.shootTime = .5;
    this.reloadTime = 4;

    this.damage = 10;
  }

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


  void reactTo(Zombie closest, Game g) {
    if (this.distanceTo(closest) > 400) return;

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
