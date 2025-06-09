import java.util.*;
import java.io.*;
int innings = 1;
int background = 0;    //0 will be front view, 1 will be top down
PImage fieldImage;
boolean cheatMode = false;
PImage ballImage;
PImage playerImage;
PImage defenderImage;
boolean remove = false;
public final int width1 = 1400;
public final int height1 = 840;
public final int FRONTVIEW = 0;
public final int TOPVIEW = 1;
public final int ENEMY_TURN = 2;
public final int ENDGAME = 3; 
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
public final PVector homePlate = new PVector(width1 / 2, height1-58);
public final PVector firstBase = new PVector((width1 / 2) + 160, height1 -220);
public final PVector secondBase = new PVector(width1 / 2, height1 - 380);
public final PVector thirdBase = new PVector((width1 / 2) - 160, height1 - 220);
private int swingDistance;
private boolean swinging = false;
public boolean pitching = false;
public boolean ballCaught = false;
public boolean ballThrown = false;
public boolean homerun = false;
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


int enemyScore = 0;
int enemyTurnStartTime = 0;
int enemyTotal = 0;

PFont varsity;



void setup() {
  size(1400, 840);
  fieldImage = loadImage("Field.png");
  ballImage = loadImage("Ball.png");
  playerImage = loadImage("Player.png");
  defenderImage = loadImage("Defender.png");
  swingDistance = 0;
  hitter1.position = homePlate.copy();
  resetDefenders();
  //varsity = createFont("varsity_regular.ttf", 24);
  //textFont(varsity);
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
  if (innings > 9 && runs != enemyScore) background = ENDGAME;
  if (background == ENDGAME) {
    background(0);
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text("Final Score: " + enemyScore + " to " + runs, width/2, height/2);
    if(enemyScore < runs){
      text("YOU WIN!", width/2, height/2 - 50);
    }
    else{
      text("you lose", width/2, height/2 - 50);
    }
    if (millis() - enemyTurnStartTime > 5000) {
      innings++;
      enemyTotal += enemyScore; 
    reset();
        textSize(12);
  }
}
    

  if (background == FRONTVIEW) { //Batting View
  //  if (outs >= 3){
  //    innings++;
 //     reset();
 //   }
      if (outs >= 3) {
    // Start enemy turn
    background = ENEMY_TURN;
    enemyScore = (int)random(0, 6);
    enemyTurnStartTime = millis();
    return;
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
else if (background == ENEMY_TURN) {
  background(0);
  fill(255);
  textSize(40);
  textAlign(CENTER);
  text("Enemy Turn", width/2, height/2 - 50);
  if(enemyScore == 1){
      text("They scored " + enemyScore + " run!", width/2, height/2);
  }
  else{
  text("They scored " + enemyScore + " runs!", width/2, height/2);
  }
  if (millis() - enemyTurnStartTime > 5000) {
    innings++;
      enemyTotal += enemyScore; 
    reset();
      textSize(12);
    background = 0; 
  }
}
  else if (background == TOPVIEW) { //Top View
    topDownView();
    displayPlayers();

    movePlayers();
    moveDefenders();

    ball1.tickTop();
    ball1.displayTop();
  } //End Top View

}


void keyPressed() {
  if (key == 'c') {
  cheatMode = !cheatMode;
<<<<<<< HEAD
  }
  if (key == '9' && innings < 9) {
    innings = 9;
    reset();
  }
  if (key == 'b') {
    switchView();
  }
  if (key == '!') {
    for (Baserunner runner : runners){
    if (runner.onBase == 1){
      on1 = true;
    }
    }
    if (!on1){
    runners.add(new Baserunner(hitter1.strength,hitter1.speed,firstBase.copy(),1));
    }
    on1 = false;
  }
  if (key == '@') {
    for (Baserunner runner : runners){
    if (runner.onBase == 2){
      on2 = true;
    }
    }
    if (!on2){
    runners.add(new Baserunner(hitter1.strength,hitter1.speed,secondBase.copy(),2));
    }
    on2 = false;
  }
  if (key == '#') {
    for (Baserunner runner : runners){
    if (runner.onBase == 3){
      on3 = true;
    }
    }
    if (!on3){
    runners.add(new Baserunner(hitter1.strength,hitter1.speed,thirdBase.copy(),3));
    }
    on3 = false;
  }
=======
}
//  if (key == 'b') {
  //  switchView();
 // }
>>>>>>> 9608fa2534f022e926614475c19b298ae36b97c4
  if(key == ' '){
    if (background == TOPVIEW && ball1.heightTop == 0 && playersOnBase()){
      background = 0;
      homerun = false;
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
bat1.startSwing();
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
  textAlign(LEFT);
  background(135, 206, 235);

  fill(34, 139, 34);
  rect(0, height * 2 / 3, width, height / 3);
  text("Click space to pitch the ball and to go back to hitting", 20, 30);
  text("Click with your mouse to swing the bat", 20, 50);
  if (cheatMode) {
  fill(255, 255, 0);
  text("CHEAT MODE: Ball will pause at max size until hit", 20, 170);
}
 // text("Balls : " + balls, 20, 70);
 // text("Strikes : " + strikes, 20, 90);
 // text("Swinging = " + swinging, 20, 70);
//  text("Outs: " + outs, 20, 110);
//  text("Runs: " + runs, 20, 130);
 //   text("Inning : " + innings, 20, 150);
  fill(255, 255, 255, 80);

  //MAKING SCOREBUG ---------
  rect(825, 50, 465, 150);
  line(1100,50,1100,200);
  line(825, 125, 900,125);
  line(900, 50, 900, 200);
  if (on1) fill(255,255,0);
  else fill(255,255,255);
    quad(1240, 107.5, 1280, 147.5, 1240, 187.5, 1200, 147.5);
  on1 = false;
  if (on2) fill(255,255,0);
  else fill(255,255,255);
    quad(1195, 62.5, 1235, 102.5, 1195, 142.5, 1155, 102.5);
  on2 = false;
  if (on3) fill(255,255,0);
  else fill(255,255,255);
    quad(1150, 107.5, 1190, 147.5, 1150, 187.5, 1110, 147.5);
  on3 = false;
  //BALLS
  if (balls > 0) fill(255,255,0);
  else fill(255,255,255);
  circle(930,80,40);
  if (balls > 1) fill(255,255,0);
  else fill(255,255,255);
  circle(975,80,40);
  if (balls > 2) fill(255,255,0);
  else fill(255,255,255);
  circle(1020,80,40);
  if (balls > 3) fill(255,255,0);
  else fill(255,255,255);
  circle(1065,80,40);

  //STRIKES
  if (strikes > 0) fill(255,255,0);
  else fill(255,255,255);
  circle(930,125,40);
  if (strikes > 1) fill(255,255,0);
  else fill(255,255,255);
  circle(975,125,40);
  if (strikes > 2) fill(255,255,0);
  else fill(255,255,255);
  circle(1020,125,40);

  //OUTS
  if (outs > 0) fill(199,30,30);
  else fill(255,255,255);
  circle(930,170,40);
  if (outs > 1) fill(199,30,30);
  else fill(255,255,255);
  circle(975,170,40);
  if (outs > 2) fill(199,30,30);
  else fill(255,255,255);
  circle(1020,170,40);

  //SCORE
  text("YOU",835,75);
  text("THEM",830,150);
  textSize(50);
  text(runs,835,120);
  text(enemyTotal,835,195);
  textSize(24);

  //INNING
  text("INN",1050,130);
  textSize(50);
  text(innings,1050,180);
  textSize(24);

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

  image(fieldImage, 0, 0);

  displayInstructions();
  
  if (homerun){
    fill(255, 255, 100);
    textSize(70);
    text("HOMERUN!", width/2 + 285, 200);
    
    runAll();
  }
  
  if (foul){
    fill(255, 100, 100);
    textSize(70);
    text("FOUL BALL!", width/2 + 285, 200);
  }
}

void displayInstructions() {
  if (homerun || foul){ return; }
  
  fill(255);
  textSize(20);
  for (Baserunner runner : runners) {
    if (runner.onBase == 1 && runner.velocity.mag() == 0){
      text("Click 1 to run from first to second base", 20, 30);
    }
    if (runner.onBase == 2 && runner.velocity.mag() == 0){
      text("Click 2 to run from second to third base", 20, 60);
    }
    if (runner.onBase == 3 && runner.velocity.mag() == 0){
      text("Click 3 to run home after the hit", 20, 90);
    }
  }
}

void runAll(){
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
  for (Baserunner player : runners){
    if (player.onBase == 3) player.run();
  }
}

void reset(){
  foul = false;
  homerun = false;
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

 // runs = 0;

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
    else if (player.position.y < secondBase.y){
      player.stop();
      player.onBase = 2;
    }
    else if (player.position.x < thirdBase.x){
      player.stop();
      player.onBase = 3;
    }
    else if (player.position.y > homePlate.y){
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
  outfielders.add(new Outfielder(10, 1, new PVector(width/2 - 200, height/2)));
  outfielders.add(new Outfielder(10, 1, new PVector(width/2 + 200, height/2)));
  outfielders.add(new Outfielder(10, 1, new PVector(width/2, height/2 - 200)));
  outfielders.add(new Outfielder(10, 1, new PVector((width/2), height/2 + 200)));
  basemen = new ArrayList<Outfielder>();
  basemen.add(new Outfielder(10, 1, new PVector(0,25).add(homePlate)));
  basemen.add(new Outfielder(10, 1, new PVector(25,0).add(firstBase)));
  basemen.add(new Outfielder(10, 1, new PVector(0,-25).add(secondBase)));
  basemen.add(new Outfielder(10, 1, new PVector(-25,0).add(thirdBase)));
  ballCaught = false;
  ballThrown = false;
}

boolean outfield(PVector position){
  return position.y > -1 * position.x + 1540 ||
         position.y > position.x + 140 ||
         position.y < -1 * position.x + 700 ||
         position.y < position.x - 700;
}

boolean foulBall(Ball ball){
  return ball.positionLanding.y > -1 * ball.positionLanding.x + 1540 ||
         ball.positionLanding.y > ball.positionLanding.x + 140;
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
  for (Outfielder player : basemen){
    image(defenderImage, player.position.x - 25, player.position.y - 25);
  }
  for (Outfielder player : outfielders){
    image(defenderImage, player.position.x - 25, player.position.y - 25);
  }
  for (Baserunner player : runners){
    image(playerImage, player.position.x - 25, player.position.y - 25);
  }
}
