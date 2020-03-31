Circuit circuit;
Car bestCar;
Car myCar;

Genetic gen;

color trackCol = color(255);
color backgroundCol = color(150);

boolean turningLeft = false;
boolean turningRight = false;

void setup(){
  size(800, 600);
  
  circuit = new Circuit(out, in);
  
  gen = new Genetic(100);
  
  bestCar = gen.learnToDrive();

  //myCar = new Car(new PVector(90, 275), 0, color(255, 0, 255));
}

void draw(){
  background(backgroundCol);
  circuit.draw();
  
  bestCar.draw(false);
  bestCar.drive();     
  if(circuit.collidesWith(bestCar.position, 0.1)){
    bestCar.reset();
  }
  
  //myCar.draw(false);
  
  //float[] dists = car.getSensorsInputs();
  //int longestDistIndex = 0;
  //float longestDist = dists[0];
  //for(int i = 1; i<7; i++){
  //  if(dists[i] > longestDist){
  //    longestDist = dists[i];
  //    longestDistIndex = i; 
  //  }
  //}
  
  //if(longestDistIndex < 3)
  //  car.turnLeft();
  //else if(longestDistIndex > 3)
  //  car.turnRight();
  
  //if(turningLeft)
  //  myCar.turnLeft();
  //if(turningRight)
  //  myCar.turnRight();
  
  //myCar.forward();
  
  //if(circuit.collidesWith(myCar.position)){
  //  delay(500);
  //  car.reset();
  //  myCar.reset();
  //}
}

void keyPressed(){
  if(keyCode == 37) //left arrow
    turningLeft = true;
  else if(keyCode == 39) //right arrow
    turningRight = true;
}

void keyReleased(){
  if(keyCode == 37) //left arrow
    turningLeft = false;
  else if(keyCode == 39) //right arrow
    turningRight = false;
}
