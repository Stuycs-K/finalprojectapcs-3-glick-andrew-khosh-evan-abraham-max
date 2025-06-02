public class Hitter extends Player{
  public int heightOf;
  public int shoulderHeight;
  public int kneeHeight;

  public Hitter(){
    heightOf = 5;
    shoulderHeight = 4;
    kneeHeight = 3;
  }

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
    double angleY = (bat.y - ball.positionFront.y) / (ball.radiusFront) * 0.5 + 0.5;  //Negative is ball aimed down, max of 0.75 min of -0.25
    double angleX = (ball.positionFront.x - bat.x) / (ball.radiusFront) * 1.25;  //Negative is ball aimed left, max of 0.75 min of -0.75
    if (angleY > 1){ angleY = 1.0; }

    PVector forceTop = new PVector(0.0, (float) force * (-1));
    forceTop.rotate((float) angleX);
    forceTop.mult(1.0 - (float) Math.abs(angleY));

    double forceHeight = force * angleY;

    //println((ball.positionFront.x - bat.x) + ", " + ball.radiusFront);
    //println("angleY: " + angleY + " angleX: " + angleX);
    //println("forceTop: " + forceTop + " forceHeight: " + forceHeight);
    ball.hit(forceTop, forceHeight);

    return true;
  }
}
