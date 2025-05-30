import java.util.*;
import java.io.*;

public class Pitcher extends Player{
  public ArrayList<String> pitches;
  public ArrayList<Integer> velocities;
  public ArrayList<Double> spin;
  
  public Pitcher(){
    pitches = new ArrayList<String>();
    velocities = new ArrayList<Integer>();
    spin = new ArrayList<Double>();
  }
  
  public void addPitch(String pitch, int velocity, double junk){
    pitches.add(pitch);
    velocities.add(velocity);
    spin.add(junk);
  }
  
  public void pitch(){
    int chosen = (int)(Math.random()*pitches.size());
    String pitch = pitches.get(chosen);
    int velocity = velocities.get(chosen)-5+(int)(Math.random()*10);
    double junk = spin.get(chosen);
  }
}
