Ball[] balls;
int n = 150;
PVector mousePos = new PVector(width/2, height/2);

void setup(){
  size(1200, 800);
  ellipseMode(CENTER);
  balls = new Ball[n];
  for(int i = 0; i < n; i++){
     balls[i] = new Ball(); 
  }
}

void draw(){
  background(20);
  for(int i = 0; i < n; i++){
     balls[i].update();
  }
  if(mousePressed){
    mousePos = new PVector(mouseX, mouseY); 
  }
}
