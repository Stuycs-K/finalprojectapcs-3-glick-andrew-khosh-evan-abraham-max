public class Player{  
  private int strength;
  private int speed;
  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  
  public Player(){
    strength = 1;
    speed = 1;
    position = new PVector(width / 2, (height / 2) + 225);
  }
  
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
