abstract class ShootingEntity extends Entity{
  //maximum magazine size
  int maxBullets;
  
  //Time between every gunshot
  float shootTime;
  
  //Time to reload the magazine
  float reloadTime;

  //How much bullets an entity has left
  int bulletCount;
  
  //The last time this entity has shot
  TimeStamp lastShotTime;
  
  //The amount of health this entity has left
  int health;
  
  ShootingEntity(float scale, String imageFileName){
    super(scale, imageFileName);  
    
    this.lastShotTime = now();
  }
  
  //Returns true if the bullet can interact with an entity
  abstract boolean bulletInteract(Entity e);
  
  //The entity will attempt to shoot
  //Nothing will happen if it has shot recently, or if it is currently reloading
  void tryShoot(Game g, boolean makeSound)
  {
    if (this.bulletCount <= 0){
      if (!lastShotTime.hasSecsPassed(reloadTime)) return;
      
      this.bulletCount = this.maxBullets;
    }
    
    if (!lastShotTime.hasSecsPassed(this.shootTime)) return;
  
    //Make a bullet      
    Bullet b = new Bullet(this.pos, this.angle){
      @Override
      boolean interact(Entity t){
        return bulletInteract(t);
      }
    };
    
    //moves the bullet so that it wont hit the entity shooting it
    b.pos = b.pos.move(this.angle, b.radius+this.radius+1);
    
    g.bullets.add(b);
    if (makeSound){
       new SoundFile(Final_project.this, "gunshot.mp3").play();
    }
    
    this.bulletCount -= 1;
    this.lastShotTime = now();
  }
  
  //Applies damage to the entity
  public void damage(int damage)
  {
    this.health -= damage;
  }
  
  //Is alive if the health is above 0
  @Override
  public boolean isAlive()
  {
    return this.health > 0;
  }
}
