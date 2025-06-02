public class Bat{
  private int batXcor = 500;
  private int batYcor = 400;
  public Bat(){
  }
  public void swing(int i){
    //for(int i = 0; i < 10; i++){
   //println("swinging2");
      ellipse(batXcor + i*10, batYcor, 200, 40);
      
    //  }

  }
  
  public void create(){
    ellipse(batXcor,batYcor,200,40);
  }
}
