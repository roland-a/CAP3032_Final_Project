abstract class Entity
{
  float x, y, rot, speed;

  PImage entityImage;

  Entity(float x, float y, float rot, float speed)
  {
    this.x = x;
    this.y = y;
    this.rot = rot;
    this.speed = speed;
  }

  public void move()
  {
    this.x += cos(this.rot) * this.speed;
    this.y += sin(this.rot) * this.speed;
  }

  public void rotateTo(float x, float y)
  {
    this.rot = atan2(this.x - x, this.y - y);
  }
  
  public void rotateTo(Entity e)
  {
    if (e == null) return;
    
    this.rotateTo(e.x, e.y);
  }

  public float distance(Entity entity)
  {
    return dist(x, y, entity.x, entity.y);
  }

  <T extends Entity> T closest(ArrayList<T> list){
    T closest = null;
    float closestDist = -1;

    for (T s: list)
    {
      if (closest == null)
      {
        closest = s;
        closestDist = this.distance(closest);
        continue;
      }

      if (this.distance(closest) > closestDist)
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

      rotate(rot);
      image(entityImage, x, y);

    popMatrix();
  }
}
