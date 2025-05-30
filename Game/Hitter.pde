public class Hitter extends Player{
  public int heightOf;
  public int shoulderHeight;
  public int kneeHeight;
  
  public Hitter(int tall, int shoulder, int knee){
    heightOf = tall;
    shoulderHeight = shoulder;
    kneeHeight = knee;
  }
  
  public boolean hit(Ball ball, PVector bat){
    if (bat.dist(ball.positionFront) > ball.radiusFront){
      return false;
    }
    
    double force = strength * ((double) ball.radiusFront / ball.radiusMax);
    double angleY = (bat.y - ball.positionFront.y) / (2 * ball.radiusFront) + 0.25;  //Negative is ball aimed down, max of 0.75 min of -0.25
    double angleX = (ball.positionFront.x - bat.x) / (ball.radiusFront) * 0.75;  //Negative is ball aimed left, max of 0.75 min of -0.75
    
    PVector forceTop = new PVector(0.0, (float) force);
    forceTop.rotate((float) angleX * 90);
    forceTop.mult(1.0 - (float) Math.abs(angleY));
    
    double forceHeight = force * angleY;
    
    ball.hit(forceTop, forceHeight);
    
    return true;
  }
}
