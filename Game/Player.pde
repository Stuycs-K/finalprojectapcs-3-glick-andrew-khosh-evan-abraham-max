public class Player{  
  private int strength;
  private int speed;
  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  
  public Player(int str, int spd){
    strength = str;
    speed = spd;
  }
  
  public Player(int str, int spd, PVector pos){
    strength = str;
    speed = spd;
    position = pos;
  }
  
  public void move(){
    velocity.add(acceleration);
    position.add(velocity);
  }
  
  public void setAcceleration(PVector accel){
    acceleration = accel;
  }
}
