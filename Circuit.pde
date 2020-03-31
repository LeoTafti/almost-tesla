class Circuit{
  public Circuit(PVector[] borderOut, PVector[] borderIn){
    this.borderOut = borderOut;
    this.borderIn = borderIn;
  }
  
  public boolean collidesWith(PVector carPos, float precision){
    for(int i = 0; i<borderOut.length-1; i++){
      if(segmentCollides(borderOut[i], borderOut[i+1], carPos, precision))
        return true;
    }
    if(segmentCollides(borderOut[borderOut.length-1], borderOut[0], carPos, precision))
      return true;
      
    for(int i = 0; i<borderIn.length-1; i++){
      if(segmentCollides(borderIn[i], borderIn[i+1], carPos, precision))
        return true;
    }
    if(segmentCollides(borderIn[borderIn.length-1], borderIn[0], carPos, precision))
      return true;
      
    return false;
  }
  
  private boolean segmentCollides(PVector a, PVector b, PVector carPos, float precision){
    return PVector.dist(a, carPos) + PVector.dist(carPos, b) - PVector.dist(a, b) < precision;
  }
  
  public void draw(){
    strokeWeight(2);
    fill(trackCol);
    beginShape();
    for(int i = 0; i<borderOut.length; i++){
      vertex(borderOut[i].x, borderOut[i].y);
    }
    endShape(CLOSE);
    
    fill(backgroundCol);
    beginShape();
    for(int i = 0; i<borderIn.length; i++){
      vertex(borderIn[i].x, borderIn[i].y);
    }
    endShape(CLOSE);
  }
  
  private PVector[] borderOut, borderIn;
}

PVector[] in = new PVector[]{new PVector(120, 324), 
                          new PVector(120, 134), 
                          new PVector(158, 95), 
                          new PVector(300, 95), 
                          new PVector(361, 124), 
                          new PVector(495, 124), 
                          new PVector(556, 95), 
                          new PVector(621, 110), 
                          new PVector(670, 149), 
                          new PVector(670, 217), 
                          new PVector(700, 221), 
                          new PVector(700, 253), 
                          new PVector(670, 263), 
                          new PVector(670, 415), 
                          new PVector(655, 477), 
                          new PVector(612, 507), 
                          new PVector(531, 511), 
                          new PVector(473, 482), 
                          new PVector(442, 427), 
                          new PVector(444, 366), 
                          new PVector(458, 302), 
                          new PVector(449, 220), 
                          new PVector(394, 162), 
                          new PVector(320, 148), 
                          new PVector(244, 161), 
                          new PVector(199, 215), 
                          new PVector(189, 317), 
                          new PVector(178, 442), 
                          new PVector(147, 462), 
                          new PVector(112, 461), 
                          new PVector(97, 426), 
                          new PVector(108, 391)};
PVector[] out = new PVector[]{new PVector(60, 324), 
                          new PVector(60, 111), 
                          new PVector(97, 58), 
                          new PVector(159, 40), 
                          new PVector(340, 40), 
                          new PVector(388, 88), 
                          new PVector(462, 88), 
                          new PVector(512, 40), 
                          new PVector(610, 40), 
                          new PVector(662, 58), 
                          new PVector(711, 101), 
                          new PVector(732, 155), 
                          new PVector(732, 311), 
                          new PVector(700, 312), 
                          new PVector(700, 357), 
                          new PVector(732, 359), 
                          new PVector(732, 459), 
                          new PVector(723, 509), 
                          new PVector(674, 557), 
                          new PVector(596, 572), 
                          new PVector(516, 572), 
                          new PVector(453, 555), 
                          new PVector(392, 497), 
                          new PVector(373, 429), 
                          new PVector(370, 372), 
                          new PVector(384, 316), 
                          new PVector(392, 255), 
                          new PVector(377, 217), 
                          new PVector(343, 200), 
                          new PVector(303, 202), 
                          new PVector(270, 228), 
                          new PVector(257, 270), 
                          new PVector(252, 400), 
                          new PVector(238, 477), 
                          new PVector(207, 519), 
                          new PVector(159, 544), 
                          new PVector(96, 553), 
                          new PVector(47, 538), 
                          new PVector(21, 500), 
                          new PVector(17, 442), 
                          new PVector(31, 394), 
                          new PVector(56, 358)};
