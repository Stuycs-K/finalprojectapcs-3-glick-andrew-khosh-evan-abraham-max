 public class Ball{
  public PVector positionFront;       //Position in front view
  public PVector velocityFront;       //Velocity in 2D plane during front view (ex. curve ball)
  public PVector accelerationFront;   //Acceleration in 2D plane during front view (ex. curve ball)
  public float speedFront;            //Speed of ball in/out of 2D plane during front view
  public float radiusFront;           //Radius of slice of ball going through 2D plane during front view
  public float radiusMax;             //Max radius of slice of ball going through 2D plane during front view
  public PVector positionTop;         //Position in top view
  public PVector positionLanding;     //Predicted position the ball will land
  public double heightTop;            //Height in top view
  public PVector velocityTop;         //Velocity in 2D plane during top view
  public double velocityHeight;       //Velocity in/out of 2D plane during top view


  public Ball(PVector posFront, int radMax, int pitcherStrength){
    //set starting vals for front view of ball
    positionFront = posFront;
    radiusMax = radMax;
    speedFront = 0.025 * pitcherStrength;
    velocityFront = new PVector(0, 0);
    accelerationFront = new PVector(0, 0);
    //set starting vals for top view of ball
    positionTop = new PVector(homePlate.x, homePlate.y);
    positionLanding = new PVector(homePlate.x, homePlate.y);
    heightTop = 10;
    velocityTop = new PVector(0, 0);
    velocityHeight = 0;
  }

  public void tickFront(){
      if (cheatMode && radiusFront >= radiusMax) {
    radiusFront = radiusMax;
    velocityFront = new PVector(0, 0);
    accelerationFront = new PVector(0, 0);
    return;
  }
    //Increases/Decreases radiusFront according to speedFront and updates positionFront and velocityFront
    velocityFront.add(accelerationFront);
    positionFront.add(velocityFront);
    radiusFront += speedFront;
      if (radiusFront > radiusMax) {
      float bx = positionFront.x;
      float by = positionFront.y;
  //    System.out.println("bx " + bx + "by " + by);
  //    System.out.println("zoneX1: " + zoneX1 + "zoneX2" + zoneX2 + "zoneY1 " + zoneY1 + "zoneY2 " + zoneY2);
      pitching = false;
      radiusFront = 0;
      //totalPitches++;

if (bx >= zoneX1 && bx <= zoneX2 && by >= zoneY1 && by <= zoneY2||swung) {
  strikes++;
  swung = false;
 // println("Strike " + strikes);
} else {

  balls++;
//  println("Ball " + balls);
}

if (strikes >= 3) {
  outs++;
//  println("Strikeout!");
  strikes = 0;
  balls = 0;
}
if (balls >= 4) {
//  println("Walk!");
  balls = 0;
  strikes = 0;
  runners.add(new Baserunner(hitter1.strength,hitter1.speed));
  for (Baserunner player : runners){
    if (player.onBase == 0) {
      player.run();
      for (Baserunner player1 : runners){
        if (player1.onBase == 1) {
          player1.run();
          for (Baserunner player2 : runners){
            if (player2.onBase == 2){
              player2.run();
              for (Baserunner player3 : runners){
                if (player3.onBase == 3){
                   player3.run();
                }
              }
            }
          }
        }
      }
    }
  }
  switchView();
    }
  }
  }

  public void displayFront(){
    noFill();
    stroke(0);
    strokeWeight(1);
    circle(positionFront.x, positionFront.y, radiusMax * 2); // Target circle at max size
    noStroke();
    fill(255);
    circle(positionFront.x, positionFront.y, radiusFront*2);
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
      if (!ballCaught){
        velocityTop = new PVector(0, 0);
        positionLanding = new PVector(positionTop.x, positionTop.y);

        for (Outfielder catcher : outfielders){ //Ball lands in outfielder's glove
          if (catcher.position.dist(this.positionTop) < 12.5){
            this.positionTop = new PVector(catcher.position.x, catcher.position.y);
            ballCaught = true;
            runners.get(runners.size() - 1).out();
          }
        }

        for (Outfielder catcher : basemen){ //Ball lands in outfielder's glove
          if (catcher.position.dist(this.positionTop) < 12.5){
            this.positionTop = new PVector(catcher.position.x, catcher.position.y);
            ballCaught = true;
            runners.get(runners.size() - 1).out();
          }
        }

      }
    }

    if (!foul && homerun(this)){
      homerun = true;
    }
  }

  public void displayTop(){
    stroke(255, 100, 100, 100);
    strokeWeight(4);
    line(positionTop.x - (float) (0.05 * heightTop), positionTop.y - (float) (0.05 * heightTop),
         positionTop.x - velocityTop.x * 10 - (float) (0.05 * heightTop), positionTop.y - velocityTop.y * 10 - (float) (0.05 * heightTop));

    noStroke();
    fill(255, 0, 0);
    image(ballImage, positionTop.x - (float) (12.5 + 0.1 * heightTop), positionTop.y - (float) (12.5 + 0.1 * heightTop), (float) (25 + 0.1 * heightTop), (float) (25 + 0.1 * heightTop));
  }

  public void hit(PVector forceTop, double forceHeight){
    //Sets the starting velocityTop velocityHeight based on the force applied
    velocityTop = forceTop;
    velocityHeight = forceHeight*1.1;

    double time = Math.ceil((velocityHeight * 2) / 0.1);
    double dist = velocityTop.mag() * time;
    PVector direction = new PVector(velocityTop.x, velocityTop.y);

    positionLanding.add(PVector.mult(direction.normalize(), (float) dist));
  }
}
