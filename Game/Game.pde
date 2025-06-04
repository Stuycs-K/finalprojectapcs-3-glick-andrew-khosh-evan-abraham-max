import java.util.*;
import java.io.*;

int background = 0;    //0 will be front view, 1 will be top down
boolean remove = false;
public final int width1 = 1400;
public final int height1 = 840;
public final int FRONTVIEW = 0;
public final int TOPVIEW = 1;
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
Ball ball1 = new Ball(new PVector(width1/2, height1/2 - 50), 30, pitcher1.strength);
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

  if (background == FRONTVIEW) { //Batting View
    stroke(0);
    strokeWeight(1);
    frontView();

    if(swinging){
      //println("swinging");
      bat1.swing(swingDistance);
      swingDistance++;
      if(swingDistance > 20){
        swingDistance = 0;
        swinging = false;
      }
    }
    else {
      bat1.swing(0);
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
    }
    else if (background == FRONTVIEW && pitching == false){
      pitching = true;
      ball1 = pitcher1.pitch();
    }
  }
  if(key == '1'){
    for (Baserunner player : runners){
      if (player.onBase == 0) player.run();
    }
  }
  if(key == '2'){
    for (Baserunner player : runners){
      if (player.onBase == 1) player.run();
    }
  }
  if(key == '3'){
    for (Baserunner player : runners){
      if (player.onBase == 2) player.run();
    }
  }
  if(key == '4'){
    for (Baserunner player : runners){
      if (player.onBase == 3) player.run();
    }
  }
}

void mousePressed(){
  if (background == FRONTVIEW){
    swinging = true;
    if (hitter1.hit(ball1, new PVector(mouseX, mouseY))){
      hits++;
      pitching = false;
      swinging = false;
      switchView();
      runners.add(new Baserunner(hitter1.strength,hitter1.speed));
    }
  }
}

void frontView() {
  background(135, 206, 235);

  fill(34, 139, 34);
  rect(0, height * 2 / 3, width, height / 3);
  text("Click space to pitch the ball and to go back to hitting", 20, 30);
  text("Click with your mouse to swing the bat", 20, 50);
 // text("Swinging = " + swinging, 20, 70);
  text("Hits: " + hits, 20, 90);
  text("Runs: " + runs, 20, 110);
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
  
  if (!ballCaught){
    closestDefender.chaseBall(ball1); 
    if (closestDefender.position.dist(ball1.positionTop) < 12.5){
      ball1.positionTop = new PVector(closestDefender.position.x, closestDefender.position.y);
      ballCaught = true;
    }
  }
  else if (!ballThrown){
    Outfielder catcher = throwTarget();
    closestDefender.throwBall(catcher);
    ballThrown = true;
  }
  
  if (ballThrown){
    for (Outfielder catcher : basemen){
      if (catcher.position.dist(ball1.positionTop) < 12.5){
        ballThrown = false;
        int base = basemen.indexOf(catcher);
        for (Baserunner player : runners){
          if (player.velocity.mag() > 0 && player.onBase + 1 % 4 == base){
            player.out();
          }
        }
      }
    }
  }
}

Outfielder closestDefender(){
  float minDist = outfielders.get(0).position.dist(ball1.positionTop);
  Outfielder closestOutfielder = outfielders.get(0);
  
  for (Outfielder player : outfielders){
    if (player.position.dist(ball1.positionTop) < minDist){
      minDist = player.position.dist(ball1.positionTop);
      closestOutfielder = player;
    }
  }
  
  return closestOutfielder;
}

Outfielder throwTarget(){
  Outfielder catcher = basemen.get(0);
  
  for (Baserunner player : runners){
    if (player.velocity.mag() > 0){
      catcher = basemen.get(player.onBase + 1 % 4);
    }
  }
  
  return catcher;
}

void resetDefenders(){
  outfielders = new ArrayList<Outfielder>();
  outfielders.add(new Outfielder(10, 1, new PVector(width/2 - 100, height/2))); 
  
  ballCaught = false;
  ballThrown = false;
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
    fill(255);
    circle(player.position.x, player.position.y, 30);
  }
}
