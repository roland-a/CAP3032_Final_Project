abstract class ShootingEntity extends Entity{
  //Maximum magazine size
  int maxBullets;
  
  int fireRatePerSecond;
  int reloadTime;

  int bulletCount;
  int lastShotStart;
  
  int health;
  float lastShotTime;
  
  ShootingEntity(float scale, String imageFileName){
    super(scale, imageFileName);  
  }
  
  abstract boolean bulletCanHit(Entity t);
  
  void shoot(Game g)
  {
    if (this.bulletCount <= 0){
      if (millis() < this.reloadTime*1000 + this.lastShotTime) return;
      
      this.bulletCount = this.maxBullets;
    }
    
    if (millis() < 1000/(this.fireRatePerSecond) + this.lastShotTime) return;
  
    //Make a bullet      
    Bullet b = new Bullet(this.pos.move(this.angle, 5), this.angle){
      boolean canHit(Entity t){
        return bulletCanHit(t);
      }
    };        
    
    g.bullets.add(b);
    
    this.bulletCount -= 1;
    this.lastShotTime = millis();
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
