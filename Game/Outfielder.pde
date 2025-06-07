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
    velocity = PVector.sub(ball.positionTop, position);
    velocity.normalize();
    velocity.mult(speed);
    move();
  }

  public void throwBall(Outfielder catcher, Ball ball){
    PVector throwVelocity = PVector.sub(catcher.position, this.position);
    throwVelocity.normalize();
    throwVelocity.mult(this.strength * 0.2);

    ball1.velocityTop = throwVelocity;
  }

  public void catchBall(Player thrower){

  }

  public void tagRunner(Baserunner runner){

  }
}
