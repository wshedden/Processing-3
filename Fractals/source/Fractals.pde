Tree tree;
boolean forwards = true;
int i = 0;
int smoothness = 100;
float globalMult = 0.66667;

void setup(){
  size(1200, 800);
  tree = new Tree(TWO_PI*0.8);
  
}


void draw(){
  if(i == 0 || i == smoothness) forwards = !forwards;
  if(forwards) i++;
  else i--;
  background(0);
  tree = new Tree(0.5*TWO_PI*i/smoothness);
  translate(width/2, height);
  tree.branch(260, globalMult);
}


void mousePressed(){
   switch(mouseButton){
      case LEFT: globalMult += 0.01; return;
      case RIGHT: globalMult -= 0.01; return;
      default: return;
     
   }
  
}
