public class Hitter extends Player{
  private int heightOf;
  private int shoulderHeight;
  private int kneeHeight;
  
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
    double angleY = (bat.y - ball.positionFront.y) / (2 * ball.radiusFront);  //Negative is ball aimed down, max of 0.5 min of -0.5
    double angleX = (ball.positionFront.x - bat.x) / (2 * ball.radiusFront);  //Negative is ball aimed left, max of 0.5 min of -0.5
    
    PVector forceTop = new PVector(0.0, (float) force);
    forceTop.rotate((float) angleX * 90);
    
    int forceHeight;
    
    
    
    return true;
  }
}
