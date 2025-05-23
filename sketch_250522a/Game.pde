int backGround = 0;

void setup() {
  size(800, 600);
}

void draw() {
  if (backGround == 0) {
    drawBackground1();
  } else {
    drawBackground2();
  }
}
  void keyPressed() {
  if (key == 'b') {
    if(backGround == 0){
      backGround = 1;}
    else{
      backGround = 0;}
  }
}

void drawBackground1() {
  background(135, 206, 235); 

  fill(34, 139, 34);
  rect(0, height * 2 / 3, width, height / 3);


}

void drawBackground2() {
  background(135, 206, 235); 

  fill(200, 139, 34); 
  rect(0, height * 2 / 3, width, height / 3);

}
