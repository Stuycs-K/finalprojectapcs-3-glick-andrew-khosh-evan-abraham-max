public class Ball{
  public PVector positionFront;       //Position in front view
  public PVector velocityFront;       //Velocity in 2D plane during front view (ex. curve ball)
  public PVector accelerationFront;   //Acceleration in 2D plane during front view (ex. curve ball)
  public float speedFront;              //Speed of ball in/out of 2D plane during front view
  public float radiusFront;             //Radius of slice of ball going through 2D plane during front view
  public float radiusMax;               //Max radius of slice of ball going through 2D plane during front view
  public boolean radiusIncreasing;     //Radius increasing or decreasing
  public PVector positionTop;         //Position in top view
  public double heightTop;               //Height in top view
  public PVector velocityTop;         //Velocity in 2D plane during top view
  public double velocityHeight;          //Velocity in/out of 2D plane during top view
  public boolean showTarget = false;
  public boolean hideBall = false;


  public Ball(PVector posFront, int radMax){
    //set starting vals for front view of ball
    positionFront = posFront;
    radiusMax = radMax;
    radiusIncreasing = true;
    speedFront = 0.5;
    velocityFront = new PVector(0, 0);
    accelerationFront = new PVector(0, 0);
    //set starting vals for top view of ball
    positionTop = new PVector(homePlate.x, homePlate.y);
    heightTop = 10;
    velocityTop = new PVector(0, 0);
    velocityHeight = 0;
  }
  
  public void tickFront(){


    //Increases/Decreases radiusFront according to speedFront and updates positionFront and velocityFront
    velocityFront.add(accelerationFront);
    positionFront.add(velocityFront);
     
if (radiusIncreasing){
  radiusFront += speedFront;
  if (radiusFront > radiusMax){
    radiusFront = radiusMax;
    radiusIncreasing = false;
    showTarget = false;
        hideBall = true;
        if (radiusFront >= radiusMax && !pitchWasHit) {
  totalPitches++;
}

  }
}
else {
  radiusFront -= speedFront;
    if (radiusFront < 0) {
    radiusFront = 0;
    hideBall = false; 
  }
}

    
    if (radiusFront < 0){ radiusFront = 0; }
  }
  
  public void displayFront(){
    if (showTarget && radiusIncreasing) {
  noFill();
stroke(0, 0, 0, 80);
  strokeWeight(2);
  circle(positionFront.x, positionFront.y, radiusMax * 2); // Target circle at max size
  noStroke();
}
  if (!hideBall) {
  fill(255);
    circle(positionFront.x, positionFront.y, radiusFront*2);
  }
  }
  
  public void breakFront(PVector forceBreak){
    accelerationFront = forceBreak;
  }
  
  public void tickTop(){
    //Changes positionTop and heightTop based on velocityTop and velocityHeight, also applys gravity
    positionTop.add(velocityTop);
    
    velocityHeight -= 0.1;
    heightTop += velocityHeight;
    if (heightTop < 0){
      heightTop = 0;
      velocityHeight = 0;
      velocityTop = new PVector(0, 0);
    }
  }
  
  public void displayTop(){
    stroke(255, 100, 100, 100); 
line(positionTop.x, positionTop.y, positionTop.x - velocityTop.x * 5, positionTop.y - velocityTop.y * 5);

    noStroke();
    fill(255, 0, 0);
    circle(positionTop.x, positionTop.y, (float) (25 + 0.1 * heightTop));
  }
  
  public void hit(PVector forceTop, double forceHeight){
    //Sets the starting velocityTop velocityHeight based on the force applied
    velocityTop = forceTop;
    velocityHeight = forceHeight;
  }
}
