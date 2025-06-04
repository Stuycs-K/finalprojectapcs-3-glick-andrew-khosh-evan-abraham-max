public class Bat{
  private int batXcor = 500;
  private int batYcor = 400;
  public Bat(){
  }
  public void swing(int i){
    if (200-i*16 > 40){
      ellipse(batXcor + i*8, batYcor, 200-i*16, 40);
    }
    else{
      ellipse(batXcor + i*8, batYcor, 40+((i-12)*16), 40);
    }
  }
  
  public void create(){
    ellipse(batXcor,batYcor,200,40);
  }
}
