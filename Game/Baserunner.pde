 public class Baserunner extends Player{
   private int onBase; //0 for home; 1 for first; 2 for second; 3 for third//

   public Baserunner(int str, int spd){
     super(str, spd);
     position = homePlate.copy();
     onBase = 0;
   }

   public void run(){
     if (onBase == 0) velocity = new PVector(speed,-speed);
     if (onBase == 1) velocity = new PVector(-speed,-speed);
     if (onBase == 2) velocity = new PVector(-speed,speed);
     if (onBase == 3) velocity = new PVector(speed,speed);
   }

   public void stop(){
     velocity = new PVector(0,0);
   }

   public void out(){
     runners.remove(this);
     outs++;
   }
}
