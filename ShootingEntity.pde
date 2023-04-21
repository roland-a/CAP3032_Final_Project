abstract class ShootingEntity extends Entity{
  //Maximum magazine size
  int maxBullets;
  
  float shootTime;
  float reloadTime;

  int bulletCount;
  int lastShotStart;
  
  int health;
  Time lastShotTime;
  
  ShootingEntity(float scale, String imageFileName){
    super(scale, imageFileName);  
    
    this.lastShotTime = now();
  }
  
  abstract boolean bulletInteract(Entity e);
  
  void shoot(Game g)
  {
    if (this.bulletCount <= 0){
      if (!lastShotTime.hasSecsPassed(reloadTime)) return;
      
      this.bulletCount = this.maxBullets;
    }
    
    if (!lastShotTime.hasSecsPassed(this.shootTime)) return;
  
    //Make a bullet      
    Bullet b = new Bullet(this.pos, this.angle){
      boolean interact(Entity t){
        return bulletInteract(t);
      }
    };
    
    b.pos = b.pos.move(this.angle, b.radius+this.radius+1);
    
    g.bullets.add(b);
    
    this.bulletCount -= 1;
    this.lastShotTime = now();
  }
  
  public void damage(int damage)
  {
    this.health -= damage;
  }
  
  public boolean isAlive()
  {
    return this.health > 0;
  }
}
