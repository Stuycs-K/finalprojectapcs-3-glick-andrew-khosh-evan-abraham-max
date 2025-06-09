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
    if (!foul && !homerun && !outfield(ball.positionTop) && !outfield(position)){
      velocity = PVector.sub(ball.positionLanding, position);
      velocity.normalize();
      velocity.mult((float) speed * 0.7);
      move();
    }
  }

  public void throwBall(Outfielder catcher, Ball ball){
    PVector throwVelocity = PVector.sub(catcher.position, this.position);
    throwVelocity.normalize();
    ball.positionTop.add(PVector.mult(throwVelocity, 13.0)); //So ball doesn't get caught by thrower
    throwVelocity.mult(this.strength * 0.3);

    ball1.velocityTop = throwVelocity;
  }

  public void catchBall(Player thrower){

  }

  public void tagRunner(Baserunner runner){

  }
}
