
TimeStamp now(){
  return new TimeStamp(millis());
}

class TimeStamp{
  final int time;
  
  private TimeStamp(int time){
    this.time = time;
  }
  
  //Returns true if an amount of time has passed since this time and the current time
  boolean hasSecsPassed(float secs){
    return (millis()-this.time) > secs*1000;
  }
}
