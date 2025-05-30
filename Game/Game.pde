import java.util.*;
import java.io.*;

int backGround = 0;    //0 will be front view, 1 will be top down
public final PVector firstBase = new PVector((width / 2) + 150, (height / 2) + 75);
public final PVector secondBase = new PVector(width / 2, (height / 2) - 75);
public final PVector homePLate = new PVector(width / 2, (height / 2) + 225);
public final PVector thirdBase = new PVector((width / 2) - 150, (height / 2) + 75);
private int swingDistance;
private int ballRadius;
private boolean swinging = false;
private boolean pitching = false;
Bat bat1 = new Bat();
Ball ball1 = new Ball(new PVector(400,400), 50);
ArrayList<Player> bases = new ArrayList<Player>();

void setup() {
  swingDistance = 0;
  ballRadius = 100;
  size(800, 600);
}

void draw() {

  if (backGround == 0) {
    frontView();
  } else {
    topDownView();
  }
    if(swinging){
    println("swinging");
    bat1.swing(swingDistance);
    swingDistance++;
    if(swingDistance > 20){
      swingDistance = 0;
      swinging = false;
  }
    }
  else{
  bat1.swing(0);  }
  //bat1.create();}
    if(pitching){
    ball1.pitch(ballRadius);
    ballRadius -=1;
    if(ballRadius < 1){
      pitching = false;
      ballRadius = 100;}
  }
}
  void keyPressed() {
  if (key == 'b') {
    if(backGround == 0){
      backGround = 1;}
    else{
      backGround = 0;}
  }
  if(key == ' '){
  //ball1.display(10);
  pitching = true;
 // ball1.pitch();
  }
}
void mouseClicked(){
  swinging = true;
}



void frontView() {
  background(135, 206, 235);

  fill(34, 139, 34);
  rect(0, height * 2 / 3, width, height / 3);
  text("Click space to pitch the ball", 20, 30);
  text("Click with your mouse to swing the bat", 20, 50);
   text("Swinging = " + swinging, 20, 70);
  noFill();

 noFill();

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

  displayPlayers();
}

void drawBase(int x, int y){
  quad(x, y, x - 25, y + 25, x, y + 50, x + 25, y + 25);
}

void displayPlayers(){
  noStroke();
  for (Player player : bases){
    fill(0);
    circle(player.position.x, player.position.y, 30);
  }
}
