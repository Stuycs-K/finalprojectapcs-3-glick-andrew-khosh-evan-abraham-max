public class Ball{
  PVector pBat;
  PVector fBreak;
  int rBat;
  int rMax;
  PVector pPlanar;
  int pHeight;
  PVector vPlanar;
  int vHeight;
  
  public Ball(PVector posBat, int radMax){
    pBat = posBat;
    rMax = radMax;
  }
  
  public void tickBat(int vBat){
    //Increases/Decreases rBat according to vBat and moves pBat based on fBreak
  }
  
  public void breakBat(PVector forBreak){
    fBreak = forBreak;
  }
  
  public void tickPlanar(){
    //Changes pPlanar and pHeight based on vPlanar and vHeight, also applys gravity
  }
  
  public void hit(PVector fPlanar, int fHeight){
    //Sets the starting vPlanar and vHeight based on the force applied
  }
}
