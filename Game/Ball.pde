public class Ball{
  private PVector positionFront;       //Position in front view
  private PVector velocityFront;       //Velocity in 2D plane during front view (ex. curve ball)
  private PVector accelerationFront;   //Acceleration in 2D plane during front view (ex. curve ball)
  private int speedFront;              //Speed of ball in/out of 2D plane during front view
  private int radiusFront;             //Radius of slice of ball going through 2D plane during front view
  private int radiusMax;               //Max radius of slice of ball going through 2D plane during front view
  private PVector positionTop;         //Position in top view
  private int heightTop;               //Height in top view
  private PVector velocityTop;         //Velocity in 2D plane during top view
  private int velocityHeight;          //Velocity in/out of 2D plane during top view
  
  public Ball(PVector posFront, int radMax){
    positionFront = posFront;
    radiusMax = radMax;
    //set starting vals for top view of ball
  }
  
  public void tickFront(){
    //Increases/Decreases radiusFront according to speedFront and updates positionFront and velocityFront
  }
  
  public void breakFront(PVector forceBreak){
    accelerationFront = velocityFront;
  }
  
  public void tickTop(){
    //Changes pPlanar and pHeight based on vPlanar and vHeight, also applys gravity
  }
  
  public void hit(PVector forceTop, int forceHeight){
    //Sets the starting velocityTop velocityHeight based on the force applied
  }
}
