private Player[] bases;
int backGround = 0;
//0 will be front view, 1 will be top down
void setup() {
  size(800, 600);
  bases = new Player[4];
  bases[0] = new Player(1, 1, new PVector(width / 2, (height / 2) + 225));
  bases[1] = new Player(1, 1, new PVector((width / 2) + 150, (height / 2) + 75));
  bases[2] = new Player(1, 1, new PVector(width / 2, (height / 2) - 75));
  bases[3] = new Player(1, 1, new PVector((width / 2) - 150, (height / 2) + 75));
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
  text("Click space to pitch the ball", 20, 30);
  text("Click with your mouse to swing the bat", 20, 50);
  noFill();

  rect(width/2 -75, height/2 , 150, 200);
  fill(150, 75, 0);
  ellipse(200,400,200,40);
}

void topView() {
  background(200);
  noStroke();

  fill(34, 139, 34); 
  quad(width / 2, (height / 2) - 300, (width / 2) - 300, height / 2,
       width / 2, (height / 2) + 300, (width / 2) + 300, height / 2);
       
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
