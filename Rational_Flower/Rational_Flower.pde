final int n = 180;
final float phi = 0.61803398875f;
final float interval = 0.000002f;
float theta = phi;

void setup() {
  size(1200, 800);
}

void draw() {
  background(0);
  fill(255);
  textSize(20);
  text(String.format("theta = %.12f", theta), 10, 30);
  fill(125, 50, 168);
  stroke(255);
  translate(width/2, height/2);
  for (int i = 0; i < n; i++) {
    push();
    rotate(i*theta*TWO_PI);
    translate(2*i, 0);
    ellipse(0, 0, 20, 20);
    pop();
  }
  float speed = sq(15*mouseX/width);
  if(mousePressed){
     if(mouseButton == LEFT){
        theta += interval*speed; 
     } else if(mouseButton == RIGHT){
        theta -= interval*speed; 
     }
  }
}
