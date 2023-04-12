abstract class Entity
{
  float x, y, rot, speed, sizeScale = 0.5;

  PImage entityImage;
  
  boolean tintImage = false;
  color tintColor = color(255, 255.0, 255.0);

  Entity(float x, float y, float rot, float speed, String imageFileName)
  {
    this.x = x;
    this.y = y;
    this.rot = rot;
    this.speed = speed;
    
    entityImage = loadImage(imageFileName);
    entityImage.resize((int) (entityImage.width * sizeScale), (int) (entityImage.height * sizeScale));
  }

  public void move()
  {
    this.x += cos(this.rot) * this.speed;
    this.y += sin(this.rot) * this.speed;
  }
  
  public void move(ArrayList<Zombie> zombies, ArrayList<Soldier> soldiers)
  {
    float newX = this.x + cos(this.rot) * this.speed;
    float newY = this.y + sin(this.rot) * this.speed;
    
    for (Zombie z: zombies){
      if (z == this) continue;
      
      if (dist(newX, newY, z.x, z.y) < 20){
          return;
      }
    }
    for (Soldier s: soldiers){
      if (s == this) continue;
      
      if (dist(newX, newY, s.x, s.y) < 20){
          return;
      }
    }
    
    this.x = newX;
    this.y = newY;
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
    float closestDist = 200;

    for (T s: list)
    {
      //if (closest == null)
      //{
      //  closest = s;
      //  closestDist = this.distance(closest);
      //  continue;
      //}

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

      translate(x, y);
      rotate(rot);
      
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
}
