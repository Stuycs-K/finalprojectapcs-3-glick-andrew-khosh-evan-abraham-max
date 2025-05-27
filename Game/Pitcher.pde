public class Pitcher extends Player{
  ArrayList<String> pitches;
  ArrayList<int> velocities;
  ArrayList<double> spin;
  
  public Pitcher(){
    pitches = new ArrayList<String>[0];
    velocities = new ArrayList<int>[0];
    spin = new ArrayList<double>[0];
  }
  
  public void addPitch(String pitch, int velocity, double junk){
    pitches.add(pitch);
    velocities.add(velocity);
    spin.add(junk);
  }
  
  public void pitch(){
    int chosen = (int)(Math.Random()*pitches.size());
    String pitch = pitches.get(chosen);
    int velocity = velocities.get(chosen)-5+(int)(Math.Random()*10);
    double junk = spin.get(chosen);
  }
