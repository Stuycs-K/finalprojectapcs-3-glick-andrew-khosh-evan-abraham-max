public class Bat{
  public int batXcor = 500;
  public int batYcor = 400;
  public Bat(){
  }
  public void swing(double rotation){
    pushMatrix();
    translate(batXcor+100, batYcor);
    rotate(radians(180 - (float) rotation));
    
    ellipse(100, 0, 200, 40);
    popMatrix();
  }

  public void create(){
    ellipse(batXcor,batYcor,200,40);
  }
}
