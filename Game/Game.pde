int backGround = 0;
private int swingDistance;
private boolean swinging = false;
  Bat bat1 = new Bat();
//0 will be front view, 1 will be top down
void setup() {
  swingDistance = 0;
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
}
  void keyPressed() {
  if (key == 'b') {
    if(backGround == 0){
      backGround = 1;}
    else{
      backGround = 0;}
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
  background(135, 206, 235);

  fill(200, 139, 34);
  quad(width / 2, (height / 2) - 100, (width / 2) - 200, (height / 2) + 100,
       width / 2, (height / 2) + 300, (width / 2) + 200, (height / 2) + 100);

  fill(255);
  drawBase(width / 2, (height / 2) - 75);
  drawBase((width / 2) - 150, (height / 2) + 75);
  drawBase(width / 2, (height / 2) + 225);
  drawBase((width / 2) + 150, (height / 2) + 75);

  displayPlayers();
}

}
