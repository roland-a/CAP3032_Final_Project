abstract class ShootingEntity extends Entity{
  //Maximum magazine size
  int maxBullets;
  
  int fireRatePerSecond;
  int reloadTime;

  int bulletCount;
  int lastShotStart;
  
  int health;
  float lastShotTime;
  
  ShootingEntity(float x, float y, float rot, float speed, String imageFileName){
    super(x,y,rot,speed,imageFileName);  
  }
  
  void shoot(Game g)
  {
    if (bulletCount <= 0){
      if (millis() < reloadTime*1000 + lastShotTime) return;
      
      bulletCount = maxBullets;
    }
    
    if (millis() < 1000/(fireRatePerSecond) + lastShotTime) return;
  
    //Make a bullet      
    Bullet b = new Bullet(this.x + cos(rot)*10, this.y + sin(rot)*10, 0.0);        
    b.rot = this.rot;
    g.bullets.add(b);
    
    bulletCount -= 1;
    lastShotTime = millis();
  }
}
