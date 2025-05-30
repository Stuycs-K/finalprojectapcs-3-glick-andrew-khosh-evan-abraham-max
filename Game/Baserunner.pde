public class Baserunner extends Player{
   private int onBase; //1 for first; 2 for second; 3 for third//
   
   public Baserunner(int str, int spd){
     super(str, spd);
     position = homePlate;
   }
}
