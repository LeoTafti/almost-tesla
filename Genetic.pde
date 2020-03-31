import java.util.Arrays;

class Genetic{
  
  public Genetic(int numCarsPerGen){
    this.numCarsPerGen = numCarsPerGen;
  }
  
  //Returns the best car
  public Car learnToDrive(){
    
    Car[] cars = generateGenZero();
    int[] scores = new int[numCarsPerGen];
    
    int numGen = 15;
    for(int generation = 0; generation < numGen; generation++){
      println("Simulating generation : " + generation);
      scores = simulate(cars);
      
      if(generation != numGen-1){
        Car[] bestCars = getBestCars(cars, scores);
        cars = generateNextGen(bestCars);
      }
    }
    
    //Select best car of last gen
    int bestScore = Integer.MIN_VALUE;
    int bestScoreIndex = -1;
    for(int i = 0; i<numCarsPerGen; i++){
      if(scores[i] > bestScore){
        bestScore = scores[i];
        bestScoreIndex = i;
      }
    }
    
    Car best = cars[bestScoreIndex];
    println("Done learning – best car score " + best.score());
    best.reset();
    
    return best;
  }
  
  private Car[] getBestCars(Car[] cars, int[] scores){
    //Top 5% cars
      int[] indexesTopCars = indexesOfTopElements(scores, numCarsPerGen / 20);
      Car[] bestCars = new Car[numCarsPerGen / 20];
      for(int c = 0; c < bestCars.length; c++){
        bestCars[c] = cars[indexesTopCars[c]];
      }
      
      return bestCars;
  }
  
  private int[] indexesOfTopElements(int[] array, int numTopElems) {
    int[] copy = Arrays.copyOf(array,array.length);
    Arrays.sort(copy);
    int[] honey = Arrays.copyOfRange(copy,copy.length - numTopElems, copy.length);
    int[] result = new int[numTopElems];
    int resultPos = 0;
    for(int i = 0; i < array.length && resultPos < numTopElems; i++) {
        int onTrial = array[i];
        int index = Arrays.binarySearch(honey,onTrial);
        if(index < 0) continue;
        result[resultPos++] = i;
    }
    return result;
  }
  
  private Car[] generateGenZero(){
    Car[] cars = new Car[numCarsPerGen];
    for(int i = 0; i < numCarsPerGen; i++){
      cars[i] = new Car(new PVector(90, 275), 0, color(random(0, 200), random(0, 200), random(0, 200)), new NeuralNetwork(7, 2, 4, 2));
      cars[i].driveNNRandomInit();
    }
    
    return cars;
  }
  
  private Car[] generateNextGen(Car[] bestCars){
    Car[] newCars = new Car[numCarsPerGen];
    for(int c = 0; c < numCarsPerGen; c++){
      int carA_index = (int)random(0, bestCars.length);
      int carB_index = (int)random(0, bestCars.length);
      
      NeuralNetwork carA_NN = bestCars[carA_index].driveNN.copy();
      NeuralNetwork carB_NN = bestCars[carB_index].driveNN.copy();
      
      NeuralNetwork new_driveNN = carA_NN.merge(carB_NN);
      new_driveNN.mutate(0.05);
      
      newCars[c] = new Car(new PVector(90, 275), 0, color(random(0, 255), random(0, 255), random(0, 255)), new NeuralNetwork(7, 2, 4, 2));
      newCars[c].driveNN = new_driveNN;
    }
    
    return newCars;
  }
  
  //Returns score for each car in cars
  private int[] simulate(Car[] cars){
    int[] scores = new int[numCarsPerGen];
    
    int numDied = 0;
    while(numDied < cars.length){
      for(int c = 0; c < cars.length; c++){
        if(!cars[c].died){
          cars[c].drive();
          
          if(circuit.collidesWith(cars[c].position, 0.2) || cars[c].score() > 10000 || cars[c].position.x < 0 || cars[c].position.x > width || cars[c].position.y < 0 || cars[c].position.y > height){
            scores[c] = cars[c].score();
            cars[c].die();
            numDied++;
          }
        }
      }
    }
    
    return scores;
  }
  
  private int numCarsPerGen;
}
