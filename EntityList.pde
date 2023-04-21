class EntityList<T extends Entity> implements Iterable<T>{
  ArrayList<T> inner = new ArrayList<T>();
   
  EntityList(){}
  
  //Adds an entity to the list
  void add(T entity){
    this.inner.add(entity);
  }
  
  //Allows the entity list to be iterated
  @Override
  Iterator<T> iterator(){
    return this.inner.iterator();
  }
  
  //returns the size of the entity list
  int size(){
    return this.inner.size();  
  }
  
  //gets the closest entity from a position
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
  
  //Returns a random entity in the list
  //Returns null if it is empty
  T getRandom()
  {
    if (this.inner.isEmpty()) return null;
    
    return this.inner.get((int)random(this.inner.size()));
  }
  
  //Updates every entity in the list
  //Also removes entities that are not alive
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
