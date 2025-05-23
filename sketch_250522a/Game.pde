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
