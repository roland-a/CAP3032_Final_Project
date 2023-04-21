Time now(){
  return new Time(millis());
}

Time NegInfinity(){
  return new Time(Integer.MIN_VALUE);
}

class Time{
  final int time;
  
  Time(int time){
    this.time = time;
  }
  
  boolean hasSecsPassed(float secs){
    return (millis()-this.time) > secs*1000;
  }
}
