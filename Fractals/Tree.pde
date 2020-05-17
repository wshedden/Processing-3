class Tree {
  float theta;
  
  Tree(float theta) {
    this.theta = theta;
  }
  
  void branch(float len, float lenMultiplier){
    strokeWeight(2);
    stroke(100, 10, 130);
    line(0, 0, 0, -len);
    
    translate(0, -len);
    len *= lenMultiplier;
    
    if(len > 2){
       pushMatrix();
       rotate(theta);
       branch(len, lenMultiplier); 
       popMatrix();
       
       pushMatrix();
       rotate(-theta);
       branch(len, lenMultiplier);
       popMatrix();
    }
  }
}
