public class Ball{
  public PVector positionFront;       //Position in front view
  public PVector velocityFront;       //Velocity in 2D plane during front view (ex. curve ball)
  public PVector accelerationFront;   //Acceleration in 2D plane during front view (ex. curve ball)
  public int speedFront;              //Speed of ball in/out of 2D plane during front view
  public int radiusFront;             //Radius of slice of ball going through 2D plane during front view
  public int radiusMax;               //Max radius of slice of ball going through 2D plane during front view
  public PVector positionTop;         //Position in top view
  public double heightTop;               //Height in top view
  public PVector velocityTop;         //Velocity in 2D plane during top view
  public double velocityHeight;          //Velocity in/out of 2D plane during top view
  
  public Ball(PVector posFront, int radMax){
    positionFront = posFront;
    radiusMax = radMax;
    //set starting vals for top view of ball
  }
  public void display(int radius){
    circle(positionFront.x, positionFront.y, radius);
  }
  public void pitch(int i){
      display(radiusMax - i/2);}
  
  public void tickFront(){
    //Increases/Decreases radiusFront according to speedFront and updates positionFront and velocityFront
  }
  
  public void breakFront(PVector forceBreak){
    accelerationFront = velocityFront;
  }
  
  public void tickTop(){
    //Changes pPlanar and pHeight based on vPlanar and vHeight, also applys gravity
  }
  
  public void hit(PVector forceTop, double forceHeight){
    //Sets the starting velocityTop velocityHeight based on the force applied
    velocityTop = forceTop;
    velocityHeight = forceHeight;
  }
}
