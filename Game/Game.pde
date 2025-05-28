int backGround = 1;
//0 will be front view, 1 will be top down
void setup() {
  size(800, 600);
}

void draw() {
  if (backGround == 0) {
    frontView();
  } else {
    topView();
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

void frontView() {
  background(135, 206, 235); 

  fill(34, 139, 34);
  rect(0, height * 2 / 3, width, height / 3);


}

void topView() {
  background(200);
  noStroke();

  fill(34, 139, 34); 
  quad(width / 2, (height / 2) - 300, (width / 2) - 300, height / 2,
       width / 2, (height / 2) + 300, (width / 2) + 300, height / 2);
       
  fill(200, 139, 34);
  quad(width / 2, height / 2, (width / 2) - 200, (height / 2) + 100,
       width / 2, (height / 2) + 300, (width / 2) + 200, (height / 2) + 100);
       
  fill(255);
  drawBase(width / 2, (height / 2) - 200);
  drawBase((width / 2) - 175, (height / 2) - 25);
  drawBase(width / 2, (height / 2) + 150);
  drawBase((width / 2) + 175, (height / 2) - 25);
}

void drawBase(int x, int y){
  quad(x, y, x - 25, y + 25, x, y + 50, x + 25, y + 25);
}
