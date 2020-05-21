final int n = 180;
final double phi = 0.61803398875d;
final double interval = 0.000000511111d;
final float d = 20;
final float gap = 2;
double theta = phi;

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
    rotate((float)(i*theta*TWO_PI));
    translate(gap*i, 0);
    ellipse(0, 0, d, d);
    pop();
  }
  noFill();
  ellipse(0, 0, n*gap*2+d, n*gap*2+d);
  double speed = sq(15*mouseX/width);
  if(mousePressed){
     if(mouseButton == LEFT){
        theta += interval*speed; 
     } else if(mouseButton == RIGHT){
        theta -= interval*speed; 
     }
  }
}
