Zombie randomZombie(){
  return new Zombie(
    randomScreenPos().toGamePos(),
    new Angle()
  );
}

class Zombie extends ShootingEntity
{
  int damage;
  boolean main;
  
  Time lastDamageTime = now();

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
  
  boolean bulletInteract(Entity t) {
    if (t instanceof Soldier){
      ((Soldier)t).damage(10000);
    }
    if (t instanceof Zombie) {
      ((Zombie)t).damage(10);
    }
    return true;
  }

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

  public void mainUpdate(Game g)
  {
    ScreenPos mousePos = getMousePos();

    if (this.distance(mousePos)>5)
    {
      this.rotateTo(mousePos);
      this.move(this.angle, this.speed, g);
    }

    if (mousePressed && mouseButton == LEFT)
    {
      println(this.bulletCount);
      this.shoot(g);
    }

    Soldier closest = g.soldiers.closest(this.pos);
    if (closest != null)
    {
      this.attack(closest);
    }
  }


  public void hordeUpdate(Game g)
  {
    if (mousePressed && mouseButton == RIGHT && this.distance(getMousePos()) < 500)
    {
      this.rotateTo(getMousePos());
      this.move(this.angle, this.speed, g);
    } else
    {
      Soldier closest = g.soldiers.closest(this.pos);
      if (closest == null) return;

      this.rotateTo(closest);
      this.move(this.angle, this.speed, g);

      this.attack(closest);
    }
  }

  public void attack(Soldier closest)
  {
    if (!lastDamageTime.hasSecsPassed(.5)) return;
    
    float dist = this.distance(closest);

    if (dist > this.radius+closest.radius+5) return;
    
    closest.damage(this.damage);
    
    lastDamageTime = now();
  }

  public void setMain()
  {
    tintEntity(255, 50, 50);
    this.main = true;
  }

  void move(Angle angle, float speed, Game g)
  {
    GamePos proj = this.pos.move(angle, speed);

    if (proj.isOutOfBounds()){
      return;
    }

    ArrayList<Zombie> toMove = new ArrayList();
    for (Zombie z : g.zombies)
    {
      if (z == this) continue;

      float d1 = this.pos.distanceTo(z.pos);
      float d2 = proj.distanceTo(z.pos);

      if (d1>d2 && d2 < this.radius+z.radius) {
        toMove.add(z);
      }
    }

    for (Soldier s : g.soldiers)
    {
      float d1 = this.pos.distanceTo(s.pos);
      float d2 = proj.distanceTo(s.pos);

      if (d1>d2 && d2 < this.radius+s.radius)
      {
        return;
      }
    }

    for (Zombie z : toMove)
    {
      z.move(angle, speed/(toMove.size()+1), g);
    }
    this.pos = this.pos.move(angle, speed/(toMove.size()+1));
  }
}
