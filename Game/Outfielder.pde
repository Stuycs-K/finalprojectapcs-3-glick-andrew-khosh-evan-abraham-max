public class Outfielder extends Player{
  
  public Outfielder(){
  }
  
  public Outfielder(int str, int spd){
    super(str, spd);
  }
  
  public Outfielder(int str, int spd, PVector pos){
    super(str, spd, pos);
  }
  
  public void chaseBall(Ball ball){
    velocity = ball.positionTop.sub(position);
    velocity.normalize();
    velocity.mult(speed);
    move();
  }
  
  public void throwBall(Outfielder catcher){
    
  }
  
  public void catchBall(Player thrower){
    
  }
  
  public void tagRunner(Baserunner runner){
    
  }
}
