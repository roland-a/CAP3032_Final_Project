//Generates a zombie at a random position
Zombie randomZombie() {
  return new Zombie(
    randomScreenPos(),
    new Angle()
  );
}

class Zombie extends ShootingEntity
{
  int damage;
  float damageTime = .2;
  TimeStamp lastDamageTime = now();
  
  boolean main;

  Zombie(GamePos pos, Angle angle)
  {
    super(.5, "zombie.png");


    this.radius = 10;
    this.speed = 4;
    this.maxBullets = 10;
    this.reloadTime = 0;
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

  //Updates the zombie depending if it is a main or hoard
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
  //flash if it has recently spawned
  //moves the zombie to the mouse position
  //attack the nearest soldier if its close enough
  private void mainUpdate(Game g)
  {
    if (!this.spawnTime.hasSecsPassed(1)){
      this.tintImage = g.ticksPassed/3 % 2 == 0;
    }
    else {
      this.tintImage = true;
    }
    
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
      this.tryShoot(g, true);
    }

    //try to attack the closest soldier
    Soldier closest = g.soldiers.closest(this.pos);
    if (closest != null)
    {
      this.tryAttack(closest);
    }
  }

  //updates the hoard
  //attacks the nearest soldier if its close enough
  public void hordeUpdate(Game g)
  {
    Soldier closest = g.soldiers.closest(this.pos);
    
    if (closest == null) return;
    
    this.rotateTo(closest);
    this.move(this.angle, this.speed, g);
    
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
    
    this.spawnTime = now();
  }

  //Moves the current zombie
  //will also push other zombies in the way
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
