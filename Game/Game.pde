import java.util.*;
import java.io.*;
int innings = 1;
int background = 0;    //0 will be front view, 1 will be top down
boolean remove = false;
public final int width1 = 1400;
public final int height1 = 840;
public final int FRONTVIEW = 0;
public final int TOPVIEW = 1;
public boolean foul = false;
public boolean swung = false;
public boolean on1 = false;
public boolean on2 = false;
public boolean on3 = false;
int strikes = 0;
int balls = 0;
int outs = 0;
float zoneX1 = width1/2 - 75;
float zoneX2 = width1/2 + 75;
float zoneY1 = (height1*2/3) - 250;
float zoneY2 = (height1*2/3) - 50;
public final PVector homePlate = new PVector(width1 / 2, height1-70);
public final PVector firstBase = new PVector((width1 / 2) + 155, height1 -225);
public final PVector secondBase = new PVector(width1 / 2, height1 - 380);
public final PVector thirdBase = new PVector((width1 / 2) - 155, height1 - 225);
private int swingDistance;
private boolean swinging = false;
public boolean pitching = false;
public boolean ballCaught = false;
public boolean ballThrown = false;
Bat bat1 = new Bat();
Hitter hitter1 = new Hitter();
Pitcher pitcher1 = new Pitcher();
Ball ball1 = new Ball(new PVector(width1/2, height1/2 - 50), 20, pitcher1.strength);
ArrayList<Baserunner> runners = new ArrayList<Baserunner>();
ArrayList<Outfielder> outfielders = new ArrayList<Outfielder>();
ArrayList<Outfielder> basemen = new ArrayList<Outfielder>();
int hits = 0;
int runs = 0;
int totalPitches = 0;


void setup() {
  size(1400, 840);
  swingDistance = 0;
  hitter1.position = homePlate.copy();
  resetDefenders();
}

void draw() {
  for (Baserunner runner : runners){
    if (runner.onBase == 1){
      on1 = true;
    }
    if (runner.onBase == 2){
      on2 = true;
    }
    if (runner.onBase == 3){
      on3 = true;
    }
  }

  if (background == FRONTVIEW) { //Batting View
    if (outs >= 3){
      innings++;
      reset();
    }
    stroke(0);
    strokeWeight(1);
    frontView();

    if(swinging){
      bat1.swing(swingDistance);
      swingDistance++;

      if(swingDistance > 20){
        swingDistance = 0;
        swung = true;
        swinging = false;
      }
    }
    else {
      bat1.create();
    }

    if(pitching){
      ball1.tickFront();
      ball1.displayFront();
    }
  } //End Batting View

  else { //Top View
    topDownView();
    displayPlayers();

    movePlayers();
    moveDefenders();

    ball1.tickTop();
    ball1.displayTop();
  } //End Top View

}

void keyPressed() {
  if (key == 'b') {
    switchView();
  }
  if(key == ' '){
    if (background == TOPVIEW && ball1.heightTop == 0 && playersOnBase()){
      background = 0;
      resetDefenders();
      if (foul){
        runners.remove(runners.size() - 1);
        foul = false;
      }
    }
    else if (background == FRONTVIEW && pitching == false){
      pitching = true;
      ball1 = pitcher1.pitch();
      ball1.velocityFront = new PVector(random(-0.75, 0.75), 0);
      ball1.accelerationFront = new PVector(0, random(0.02, 0.03));
      /*
          ball1 = new Ball(new PVector(width1/2, height1/2 - 50), 20);
          }
          else if (background == FRONTVIEW && pitching == false){
            pitching = true;
            ball1.positionFront = new PVector(width1/2, height1/2 - 50);
           ball1.velocityFront = new PVector(random(-1.3, 1.3), 0);
           ball1.accelerationFront = new PVector(0, random(0.02, 0.03));
           */
    }
  }
  /*if(key == '0'){
    for (Baserunner player : runners){
      if (player.onBase == 0) player.run();
>>>>>>> 22c7db9d404c2b89632db0f3fb88bab77059aa11
    }
  }*/
  if(key == '1'){
    for (Baserunner player : runners){
      if (player.onBase == 1) {
        player.run();
        for (Baserunner player1 : runners){
          if (player1.onBase == 2){
            player1.run();
            for (Baserunner player2 : runners){
              if (player2.onBase == 3){
                player2.run();
              }
            }
          }
        }
      }
    }
  }
  if(key == '2'){
    for (Baserunner player : runners){
      if (player.onBase == 2) {
        player.run();
        for (Baserunner player1 : runners){
          if (player1.onBase == 3) {
            player1.run();
          }
        }
      }
    }
  }
  if(key == '3'){
    for (Baserunner player : runners){
      if (player.onBase == 3) player.run();
    }
  }
}

void mousePressed(){
  if (background == FRONTVIEW){
    swinging = true;
    if (hitter1.hit(ball1, new PVector(mouseX, mouseY))){
      foul = foulBall(ball1);
      runners.add(new Baserunner(hitter1.strength,hitter1.speed));
      pitching = false;
      swinging = false;
      switchView();
      if (foul){
        if (strikes < 2){
          strikes++;
        }
      }
      else {
        balls = 0;
        strikes = 0;
        hits++;
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
      }
    }
  }
}

void frontView() {
  background(135, 206, 235);

  fill(34, 139, 34);
  rect(0, height * 2 / 3, width, height / 3);
  text("Click space to pitch the ball and to go back to hitting", 20, 30);
  text("Click with your mouse to swing the bat", 20, 50);
  text("Balls : " + balls, 20, 70);
  text("Strikes : " + strikes, 20, 90);
 // text("Swinging = " + swinging, 20, 70);
  text("Outs: " + outs, 20, 110);
  text("Runs: " + runs, 20, 130);
    text("Inning : " + innings, 20, 150);  
  fill(255, 255, 255, 80);
  //MAKING SCOREBUG ---------
  rect(1100, 50, 200, 100);
  if (on1) fill(255,255,0);
  else fill(255,255,255);
  quad(1200+35, 100, 1215+35, 115, 1200+35, 130 ,1185+35, 115);
  on1 = false;
  if (on3) fill(255,255,0);
  else fill(255,255,255);
  quad(1200, 100, 1215, 115, 1200, 130 ,1185, 115);
  on3 = false;
  if (on2) fill(255,255,0);
  else fill(255,255,255);
  quad(1200+17.5, 100-17.5, 1215+17.5, 115-17.5, 1200+17.5, 130-17.5 ,1185+17.5, 115-17.5);
  on2 = false;
  //END OF SCOREBUG -----------
  fill(255, 255, 255, 80);
  rect(width/2 - 75, (height*2/3) - 250 , 150, 200);
  fill(150, 75, 0);
  //bat1.create();
  //ellipse(200,400,200,40);

}

void topDownView() {
  background(200);
  noStroke();

  fill(34, 139, 34);
  quad(width / 2, 0, (width/2)-(height / 2), height / 2,
       width / 2, height, (width/2)+(height / 2), (height / 2));

  fill(200, 139, 34);
  quad(width / 2, height - 400, (width / 2) - 200, height- 200,
       width / 2, height, (width / 2) + 200, height -200);

  fill(255);
  drawBase(firstBase.x, firstBase.y);
  drawBase(secondBase.x, secondBase.y);
  drawBase(thirdBase.x, thirdBase.y);
  drawBase(homePlate.x, homePlate.y);
}

void reset(){
  foul = false;
  swung = false;
  on1 = false;
  on2 = false;
  on3 = false;
  strikes = 0;
  balls = 0;
  outs = 0;
  swinging = false;
  pitching = false;
  runners = new ArrayList<Baserunner>();
  resetDefenders();
  hits = 0;
  runs = 0;
  totalPitches = 0;
}

boolean playersOnBase(){
  for (Baserunner player : runners){
     if (player.velocity.mag() > 0){
      return false;
    }
  }
  return true;
}

void movePlayers(){
  for (Baserunner player : runners){
    player.move();
    if (player.position.x > firstBase.x){
      player.stop();
      player.onBase = 1;
    }
    else if (player.position.y < secondBase.y + 25){
      player.stop();
      player.onBase = 2;
    }
    else if (player.position.x < thirdBase.x){
      player.stop();
      player.onBase = 3;
    }
    else if (player.position.y > homePlate.y + 25){
      player.stop();
      player.position = new PVector(10000,10000);
      remove = true;
      runs++;
    }
  }
  if (remove){
    runners.remove(0);
    remove = false;
  }
}

void moveDefenders(){
  Outfielder closestDefender = closestDefender();
  Outfielder closestOutfielder = closestOutfielder();

  if (!ballCaught){
    closestOutfielder.chaseBall(ball1);
    if (closestOutfielder.position.dist(ball1.positionTop) < 12.5 && ball1.heightTop == 0){
      ball1.positionTop = new PVector(closestOutfielder.position.x, closestOutfielder.position.y);
      ballCaught = true;
    }
  }
  else if (!ballThrown){
    Outfielder catcher = throwTarget(closestDefender);
    if (catcher != null){ 
      closestDefender.throwBall(catcher, ball1);
      ballThrown = true;
    }
  }

  if (ballThrown){
    for (Outfielder catcher : basemen){
      if (catcher.position.dist(ball1.positionTop) < 12.5){
        ballThrown = false;
        ball1.positionTop = new PVector(catcher.position.x, catcher.position.y);
        ball1.velocityTop = new PVector(0, 0);
        int base = basemen.indexOf(catcher);
         
        for(int i = 0; i < runners.size(); i++){
          Baserunner player = runners.get(i);
          if (player.velocity.mag() > 0 && (player.onBase + 1) % 4 == base){
            player.out();
            i--;
          }
        }
      }
    }
  }
}

Outfielder closestDefender(){
  float minDist = outfielders.get(0).position.dist(ball1.positionTop);
  Outfielder closestDefender = outfielders.get(0);

  for (Outfielder player : outfielders){
    if (player.position.dist(ball1.positionTop) < minDist){
      minDist = player.position.dist(ball1.positionTop);
      closestDefender = player;
    }
  }
  for (Outfielder player : basemen){
    if (player.position.dist(ball1.positionTop) < minDist){
      minDist = player.position.dist(ball1.positionTop);
      closestDefender = player;
    }
  }

  return closestDefender;
}

Outfielder closestOutfielder(){
  float minDist = outfielders.get(0).position.dist(ball1.positionLanding);
  Outfielder closestOutfielder = outfielders.get(0);

  for (Outfielder player : outfielders){
    if (player.position.dist(ball1.positionLanding) < minDist){
      minDist = player.position.dist(ball1.positionLanding);
      closestOutfielder = player;
    }
  }

  return closestOutfielder;
}

Outfielder throwTarget(Outfielder thrower){
  Outfielder catcher = null;
  float minDist = -1.0;

  for (Baserunner player : runners){
    if (player.velocity.mag() > 0 && thrower != basemen.get((player.onBase + 1) % 4)){
      if (minDist < 0 || minDist > thrower.position.dist(basemen.get((player.onBase + 1) % 4).position)){
        catcher = basemen.get((player.onBase + 1) % 4);
        minDist = thrower.position.dist(catcher.position);
      }
    }
  }

  return catcher;
}

void resetDefenders(){
  outfielders = new ArrayList<Outfielder>();
  outfielders.add(new Outfielder(10, 1, new PVector(width/2 - 180, height/2)));
  outfielders.add(new Outfielder(10, 1, new PVector(width/2 + 180, height/2)));
  outfielders.add(new Outfielder(10, 1, new PVector(width/2, height/2 - 200)));
  outfielders.add(new Outfielder(10, 1, new PVector((width/2)-40, height/2 + 100)));
  basemen = new ArrayList<Outfielder>();
  basemen.add(new Outfielder(10, 1, new PVector(40,66).add(homePlate)));
  basemen.add(new Outfielder(10, 1, new PVector(-40,-14).add(firstBase)));
  basemen.add(new Outfielder(10, 1, new PVector(40,66).add(secondBase)));
  basemen.add(new Outfielder(10, 1, new PVector(40,-14).add(thirdBase)));
  ballCaught = false;
  ballThrown = false;
}

boolean outfield(PVector position){
  return position.y > -1 * position.x + 1540 ||
         position.y > position.x + 770 ||
         position.y < -1 * position.x + 770 ||
         position.y < position.x - 700;
}

boolean foulBall(Ball ball){
  return ball.positionLanding.y > -1 * ball.positionLanding.x + 1540 ||
         ball.positionLanding.y > ball.positionLanding.x + 770;
}

void drawBase(float x, float y){
  quad(x, y, x - 25, y + 25, x, y + 50, x + 25, y + 25);
}

void switchView(){
  if (background == FRONTVIEW){
    background = TOPVIEW;
  }
  else {
    background = FRONTVIEW;
  }
}

void displayPlayers(){
  noStroke();
  for (Baserunner player : runners){
    fill(0);
    circle(player.position.x, player.position.y, 30);
  }
  for (Outfielder player : outfielders){
    fill(255, 255, 0);
    circle(player.position.x, player.position.y, 30);
  }
    for (Outfielder player : basemen){
    fill(255, 165, 0);
    circle(player.position.x, player.position.y, 30);
  }
}
