public class Player{  
  public int strength;
  public int speed;
  public PVector position;
  public PVector velocity;
  
  public Player(){
    strength = 10;
    speed = 1;
    position = new PVector(width / 2, (height / 2) + 225);
    velocity = new PVector(0,0);
  }
  
  public Player(int str, int spd){
    strength = str;
    speed = spd;
    velocity = new PVector(0,0);
  }
  
  public Player(int str, int spd, PVector pos){
    strength = str;
    speed = spd;
    position = pos;
    velocity = new PVector(0,0);
  }
  
  public void move(){
    position.add(velocity);
  }
  
  //public void setAcceleration(PVector accel){
  //  acceleration = accel;
  //}
}
