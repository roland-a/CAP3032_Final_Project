class EntityList<T extends Entity> implements Iterable<T>{
  ArrayList<T> inner = new ArrayList<T>();
   
  EntityList(){}
  
  
  void add(T entity){
    this.inner.add(entity);
  }
  
  Iterator<T> iterator(){
    return this.inner.iterator();
  }
  
  int size(){
    return this.inner.size();  
  }
  
  T closest(GamePos p)
  {
    T closest = null;
    float closestDist = Float.POSITIVE_INFINITY;

    for (T s: this.inner)
    {
      float d = p.distanceTo(s.pos);
      
      if (d < closestDist)
      {
        closest = s;
        closestDist = d;
      }
    }

    return closest;
  }
  
  T getRandom()
  {
    if (this.inner.isEmpty()) return null;
    
    return this.inner.get((int)random(this.inner.size()));
  }
  
  void update(Game g)
  {
    Iterator<T> iter = this.inner.iterator();
    while (iter.hasNext())
    {
      T t = iter.next();
      t.update(g);
      
      if (!t.isAlive())
      {
        iter.remove();  
      }
    }
  }
}
