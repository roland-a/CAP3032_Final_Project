abstract class Entity
{
  float x, y, rot, speed;

  PImage entityImage;

  Entity(float x, float y, float rot, float speed, String imageFileName)
  {
    this.x = x;
    this.y = y;
    this.rot = rot;
    this.speed = speed;
    
    entityImage = loadImage(imageFileName);
  }

  public void move()
  {
    this.x += cos(this.rot) * this.speed;
    this.y += sin(this.rot) * this.speed;
  }

  public void rotateTo(float targetX, float targetY)
  {    
    this.rot = atan2(targetY-y, targetX-x);
  }
  
  public void rotateTo(Entity e)
  {
    if (e == null) return;
    
    this.rotateTo(e.x, e.y);
  }

  public float distance(Entity e)
  {
    if (e == null) return 0;
    
    return dist(x, y, e.x, e.y);
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

      if (this.distance(closest) < closestDist)
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

      translate(x, y);
      rotate(rot);
      
      imageMode(CENTER);
      image(entityImage, 0, 0);

    popMatrix();
  }
}
