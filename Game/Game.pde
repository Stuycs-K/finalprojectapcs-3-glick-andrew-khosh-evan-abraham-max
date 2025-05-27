int backGround = 0;
//0 will be front view, 1 will be top down
void setup() {
  size(800, 600);
}

void draw() {
  if (backGround == 0) {
    frontView();
  } else {
    topDownView();
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
 noFill();
  rect(width/2 -75, height/2 , 150, 200);


}

void topDownView() {
  background(135, 206, 235); 

  fill(200, 139, 34); 
  rect(0, height * 2 / 3, width, height / 3);

}
