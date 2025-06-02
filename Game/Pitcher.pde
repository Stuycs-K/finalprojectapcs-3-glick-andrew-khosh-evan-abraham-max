import java.util.*;
import java.io.*;

public class Pitcher extends Player{
  public ArrayList<String> pitches;
  
  public Pitcher(){
    pitches = new ArrayList<String>();
    pitches.add("fast"); pitches.add("curve"); pitches.add("change");
  }
  
  public Ball pitch(){
    int chosen = (int)(Math.random()*pitches.size());
    String pitch = pitches.get(chosen);
    
    Ball ball = new Ball(new PVector(width1/2, height1/2 - 50), 30);
    ball.velocityFront = new PVector(random(-0.75, 0.75), 0);
    ball.accelerationFront = new PVector(0, random(0.03, 0.08));
    ball.speedFront = strength / 20;
    return ball;
    
    /*
    if (pitch = "fast"){
    }
    if (pitch = "curve"){
    }
    if (pitch = "change"){
    }
    */
  }
}
