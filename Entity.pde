abstract class Entity
{
  final PImage entityImage;
  
  boolean tintImage = false;
  color tintColor = color(255, 255.0, 255.0);
  
  float speed;
  
  GamePos pos;
  Angle angle;

  Entity(float sizeScale, String imageFileName)
  {
    entityImage = loadImage(imageFileName);
    entityImage.resize((int) (entityImage.width * sizeScale), (int) (entityImage.height * sizeScale));
  }
  
  abstract boolean isAlive();

  public void move(boolean forwards)
  {
    if (outOfBounds())
    {
      forwards = !forwards;
    }
    else
    {
      if (forwards)
      {
        this.pos = this.pos.move(this.angle, this.speed);
      }
      else
      {      
        this.pos = this.pos.move(this.angle.flip(), this.speed);
      }
    }
  }
  
  public void rotateTo(Entity e)
  {
    if (e == null) return;
    
    this.angle = this.pos.pointTo(e.pos);
  }
  
  public void rotateTo(GamePos p)
  {
    this.angle = this.pos.pointTo(p);
  }
  
    public void rotateTo(ScreenPos p)
  {
    this.angle = this.pos.pointTo(p.toGamePos());
  }

  public float distance(Entity e)
  {
    if (e == null) return -1;
    
    return this.pos.distanceTo(e.pos);
  }
  
  public float distance(GamePos pos)
  {
    return this.pos.distanceTo(pos);
  }
  
  public float distance(ScreenPos pos)
  {
    return this.pos.distanceTo(pos.toGamePos());
  }

  <T extends Entity> T closest(ArrayList<T> list){
    T closest = null;
    float closestDist = 200;

    for (T s: list)
    {
      if (this.distance(s) < closestDist)
      {
        closest = s;
        closestDist = this.distance(closest);
      }
    }

    return closest;
  }

  public void drawEntity()
  {
    pushMatrix();

      translate(pos.x, pos.y);
      rotate(angle.angle);
      
      imageMode(CENTER);
      if (tintImage)
      {
        tint(tintColor);
      }
      else
      {
        tint(255.0, 255.0, 255.0);
      }
      image(entityImage, 0, 0);

    popMatrix();
  }
  
  public void tintEntity(float r, float g, float b)
  {
    tintImage = true;
    tintColor = color(r, g, b);
  }
  
  public boolean outOfBounds()
  {
    return this.pos.x > width || this.pos.x < 0 || this.pos.y > height || this.pos.y < 0;
  }
  
  public <T extends Entity> boolean closeToEntity(ArrayList<T> entities)
  {
    boolean close = false;
    for (Entity e : entities)
    {
      if (this.distance(e) != -1 && this.distance(e) < 50)
      {
        close = true;
      }
    }
    return close;
  }
}
