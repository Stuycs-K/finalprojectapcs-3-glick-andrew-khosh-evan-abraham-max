import java.util.*;
import java.io.*;

int background = 0;    //0 will be front view, 1 will be top down
public final int FRONTVIEW = 0;
public final int TOPVIEW = 1;
public final PVector homePlate = new PVector(800 / 2, (600 / 2) + 225);
public final PVector firstBase = new PVector((800 / 2) + 150, (600 / 2) + 75);
public final PVector secondBase = new PVector(800 / 2, (600 / 2) - 75);
public final PVector thirdBase = new PVector((800 / 2) - 150, (600 / 2) + 75);
private int swingDistance;
private boolean swinging = false;
private boolean pitching = false;
Bat bat1 = new Bat();
Ball ball1 = new Ball(new PVector(400,400), 30);
Hitter hitter1 = new Hitter();
ArrayList<Player> bases = new ArrayList<Player>();
int score = 0;
int totalPitches = 0;
boolean pitchWasHit = false;


void setup() {
  swingDistance = 0;
  bases.add(hitter1);
  size(800, 600);
}

void draw() {

  if (background == FRONTVIEW) { //Batting View
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
      
      if (!ball1.radiusIncreasing && ball1.radiusFront == 0){
        pitching = false;
      }
    }
  }
  
  else { //Top View
    topDownView();
    displayPlayers();
    ball1.tickTop();
    ball1.displayTop();
  }
}
  void keyPressed() {
  if (key == 'b') {
    switchView();
  }
  if(key == ' '){
    if(background == TOPVIEW){
      background = 0;
      pitching = false;
      swinging = false;
      ball1.positionTop = new PVector(homePlate.x, homePlate.y);
      ball1.heightTop = 10;
      ball1.velocityTop = new PVector(0, 0);
      ball1.velocityHeight = 0;
      pitchWasHit = false;
    }
    else{
pitching = true;
ball1.hideBall = false;
ball1.radiusIncreasing = true;
ball1.radiusFront = 0;
ball1.showTarget = true;
ball1.positionFront = new PVector(400, 300); 
ball1.velocityFront = new PVector(random(-0.75, 0.75), 0); 
ball1.accelerationFront = new PVector(0, random(0.03, 0.08)); 

  }
  }
}

void mouseClicked(){
  if (background == FRONTVIEW){ 
    swinging = true;
    if (hitter1.hit(ball1, new PVector(mouseX, mouseY))){
       score++;
  pitchWasHit = true;
      switchView();
    }
  }
}

void frontView() {
  background(135, 206, 235);

  fill(34, 139, 34);
  rect(0, height * 2 / 3, width, height / 3);
  text("Click space to pitch the ball", 20, 30);
  text("Click with your mouse to swing the bat", 20, 50);
   text("Swinging = " + swinging, 20, 70);
text("Score: " + score, 20, 90);
fill(255, 255, 255, 80); 

  rect(width/2 -75, height/2 , 150, 200);
  fill(150, 75, 0);
//  bat1.create();
  //ellipse(200,400,200,40);
}

void topDownView() {
  background(200);
  noStroke();

  fill(34, 139, 34);
  quad(width / 2, (height / 2) - 300, (width / 2) - 300, height / 2,
       width / 2, (height / 2) + 300, (width / 2) + 300, height / 2);

  fill(200, 139, 34);
  quad(width / 2, (height / 2) - 100, (width / 2) - 200, (height / 2) + 100,
       width / 2, (height / 2) + 300, (width / 2) + 200, (height / 2) + 100);

  fill(255);
  drawBase(firstBase.x, firstBase.y);
  drawBase(secondBase.x, secondBase.y);
  drawBase(thirdBase.x, thirdBase.y);
  drawBase(homePlate.x, homePlate.y);
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
  for (Player player : bases){
    fill(0);
    circle(player.position.x, player.position.y, 30);
  }
}
