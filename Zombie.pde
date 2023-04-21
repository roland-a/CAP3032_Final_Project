Zombie randomZombie() {
  return new Zombie(
    randomScreenPos(),
    new Angle()
  );
}

class Zombie extends ShootingEntity
{
  int damage;
  boolean main;

  TimeStamp lastDamageTime = now();

  Zombie(GamePos pos, Angle angle)
  {
    super(.5, "zombie.png");


    this.radius = 10;
    this.speed = 4;
    this.maxBullets = 10;
    this.reloadTime = 4;
    this.shootTime = .5;

    this.pos = pos;
    this.angle = angle;

    this.bulletCount = this.maxBullets;

    this.health = 30;
    this.damage = 10;

    this.main = false;
  }


  //Returns true if the bullet can interact with the entity
  //For the main zombie, the bullet can hit both zombies and soldiers
  //Bullets only apply 10 damage to zombies, but instantly kills and zombifies soldiers
  boolean bulletInteract(Entity t) {
    if (t instanceof Soldier) {
      ((Soldier)t).damage(10000);
    }
    if (t instanceof Zombie) {
      ((Zombie)t).damage(10);
    }
    return true;
  }

  @Override
    public void update(Game g)
  {
    drawEntity();

    if (main)
    {
      this.mainUpdate(g);
    } else
    {
      this.hordeUpdate(g);
    }
  }

  //update the zombie if it is a main zombie
  private void mainUpdate(Game g)
  {
    //move to mouse position
    //wont move if it is too close to mouse posoition
    if (this.distance(getMousePos())>5)
    {
      this.rotateTo(getMousePos());
      this.move(this.angle, this.speed, g);
    }

    //shoot if left mouse is clicked
    if (mousePressed && mouseButton == LEFT)
    {
      this.tryShoot(g);
    }

    //try to attack the closest soldier
    Soldier closest = g.soldiers.closest(this.pos);
    if (closest != null)
    {
      this.tryAttack(closest);
    }
  }


  public void hordeUpdate(Game g)
  {
    Soldier closest = g.soldiers.closest(this.pos);
    
    GamePos targetPos;
    
    if (mousePressed && mouseButton == RIGHT && this.distance(getMousePos()) < 200)
    {
      targetPos = getMousePos();
    } 
    else
    {
      if (closest == null) return;
      targetPos = closest.pos;
    }
    
    targetPos = targetPos.move(randomAngle(), 5);
    this.rotateTo(targetPos);
    this.move(this.angle, this.speed, g);
    
    if (closest == null) return;
    this.tryAttack(closest);
  }

  //Attempts to attack a given soldier
  //Does nothing if too far, or has already recently attacked
  private void tryAttack(Soldier closest)
  {
    if (!lastDamageTime.hasSecsPassed(.5)) return;

    float dist = this.distanceTo(closest);

    if (dist > this.radius+closest.radius+5) return;

    closest.damage(this.damage);

    lastDamageTime = now();
  }

  //Sets this zombie as the new main zombie
  public void setMain()
  {
    tintEntity(255, 50, 50);
    this.main = true;
    this.speed = speed+2;
  }

  //moves the current zombie
  //will also push other zombies
  private void move(Angle angle, float speed, Game g)
  {
    //The projected new position
    GamePos proj = this.pos.move(angle, speed);

    if (proj.isOutOfBounds()) {
      return;
    }

    ArrayList<Zombie> toMove = new ArrayList();
    for (Zombie z : g.zombies)
    {
      if (z == this) continue;

      float d1 = this.pos.distanceTo(z.pos);
      float d2 = proj.distanceTo(z.pos);

      //it moves the other zombie if its both getting closer to the other zombie, and will touch the other zombie
      if (d1>d2 && d2 < this.radius+z.radius) {
        toMove.add(z);
      }
    }

    for (Soldier s : g.soldiers)
    {
      float d1 = this.pos.distanceTo(s.pos);
      float d2 = proj.distanceTo(s.pos);

      //zombies cant push soldiers
      if (d1>d2 && d2 < this.radius+s.radius)
      {
        return;
      }
    }

    for (Zombie z : toMove)
    {
      //pushes the other zombie
      z.move(angle, speed/(toMove.size()+1), g);
    }
    this.pos = this.pos.move(angle, speed/(toMove.size()+1));
  }
}
