class Car{
  public Car(PVector initPos, float initAngle, color col, NeuralNetwork driveNN){
    this.initPos = initPos;
    this.initAngle = initAngle;
    this.position = new PVector(initPos.x, initPos.y);
    this.angle = initAngle;
    this.col = col;
    this.driveNN = driveNN;
    this.distTravelled = 0;
    this.numTurns = 0;
    this.died = false;
  }
  
  private void forward(){
    PVector v = new PVector(0, -2);
    v.rotate(angle);
    position.add(v);
    distTravelled++;
  }
  
  private void turnRight(){
    angle += QUARTER_PI / 24;
    numTurns++;
  }
  
  private void turnLeft(){
    angle -= QUARTER_PI / 24;
    numTurns++;
  }
  
  public void drive(){
    if(!died){
      double[] dists = getSensorsInputs();
      double[] directions = driveNN.guess(dists);
      
      if(directions[0] - directions[1] > 0.02)
        turnLeft();
      else if(directions[1] - directions[0] > 0.02)
        turnRight();
      
      forward();
    }
  }
  
  public void driveNNRandomInit(){
    for (int i = 0; i < 1000; i++) {
      double[] randInput = new double[]{random(0, 50), random(0, 75), random(0, 150), random(0, 300), random(0, 150), random(0, 75), random(0, 50)};
      double[] randOutput = new double[]{random(0, 1), random(0, 1)};
      driveNN.train(randInput, randOutput);
    }
  }
  
  public int score(){
    //println("dist: " + distTravelled + ", numTurns: " + numTurns);
    return distTravelled * 5 - numTurns;
  }
  
  public void die(){
    this.died = true;
  }
  
  public void reset(){
    position = new PVector(initPos.x, initPos.y);
    angle = initAngle;
    distTravelled = 0;
    numTurns = 0;
    died = false;
  }
  
  public double[] getSensorsInputs(){
    double[] distsFromBorder = new double[7];
    float theta = -HALF_PI;
    for(int i = 0; i < 7; i++){
      boolean exit = false;
      PVector v = new PVector(0, -0.1);
      v.rotate(angle + theta);
      v.add(position);
      while(!circuit.collidesWith(v, 5) && !exit){
        v.sub(position);
        v.mult(1.1);
        if(v.mag() >= 500)
          exit = true;
        v.add(position);
      }
      v.sub(position);
      
      if(exit) //Early exit, can happen if the sensor "missed" colliding with the border.
        distsFromBorder[i] = prevSensorsInputs[i];
      else
        distsFromBorder[i] = (double)v.mag();
      
      theta += HALF_PI / 3;
    }
    
    prevSensorsInputs = distsFromBorder;
    return distsFromBorder;
  }
  
  public void draw(boolean withSensors){
    fill(col);
    strokeWeight(1);
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    triangle(-4, 5, 0, -5, 4, 5);
    
    if(withSensors){
      double[] dists = getSensorsInputs();
      rotate(-PI);
      for(int i = 0; i<7; i++){
        line(0, 0, (float)dists[i], 0); 
        
        rotate(HALF_PI / 3);
      }
    }
    popMatrix();
  }
  
  private PVector initPos;
  private float initAngle;
  private PVector position;
  private float angle; //Angle mesured clockwise from top (like starting position from a clock);
  private color col;
  private boolean died;
  
  private NeuralNetwork driveNN;
  
  private double[] prevSensorsInputs;
  
  //To compute a score metric
  private int distTravelled;
  private int numTurns;
}
