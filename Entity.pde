abstract class Entity
{
  final PImage entityImage;
  
  boolean tintImage = false;
  color tintColor = color(255, 255.0, 255.0);
  
  int radius;
  float speed;
  
  GamePos pos;
  Angle angle;
  
  TimeStamp spawnTime;

  Entity(float sizeScale, String imageFileName)
  {
    entityImage = loadImage(imageFileName);
    entityImage.resize((int) (entityImage.width * sizeScale), (int) (entityImage.height * sizeScale));
    this.spawnTime = now();
  }
  
  //Updates the entity
  abstract void update(Game g);
  
  //Returns whether the entity is alive
  abstract boolean isAlive();

  //Moves the entity
  //Does nothing if the entity will go out of bound
  public void move(boolean forwards)
  {
    GamePos newPos;
    if (forwards)
    {
       newPos = pos.move(this.angle, this.speed);
    }
    else
    {      
      newPos = this.pos.move(this.angle.rotate(180), this.speed);
    }
    if (!newPos.isOutOfBounds()){
      this.pos = newPos;
    }
  }
  
  //Rotates this entity to face a target entity
  public void rotateTo(Entity target)
  {
    if (target == null) return;
    
    this.angle = this.pos.pointTo(target.pos);
  }
  
  //Rotates this entity to face a target position
  public void rotateTo(GamePos target)
  {
    this.angle = this.pos.pointTo(target);
  }

  //Returns the distance between this entity and a target entity
  public float distanceTo(Entity target)
  {
    if (target == null) return -1;
    
    return this.pos.distanceTo(target.pos);
  }
  
  //Returns the distance between this entity and a target position
  public float distance(GamePos target)
  {
    return this.pos.distanceTo(target);
  }

  //draws the entity
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
  
  //Tints the entity's image
  public void tintEntity(float r, float g, float b)
  {
    tintImage = true;
    tintColor = color(r, g, b);
  }
}
