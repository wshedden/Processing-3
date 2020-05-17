final float spacing = 140;
final float interval = 0.0035;
final int depth = 100;
Complex c = new Complex(0, 0);
Complex[] points;
Complex point = new Complex(0, 0);

void setup() {
  size(1400, 800);
  points = new Complex[depth];
}

void draw() {
  background(255);
  drawAxes(spacing, spacing);
  if(mousePressed){
     if(mouseButton == LEFT){
        point = getZ(); 
     }
     else if(mouseButton == RIGHT){
        c = getZ(); 
     }
  }
  generatePoints(point, points);
  plotPoints(points);
  plot(c.real, c.imaginary, color(230, 39, 55));
  displayFunction(point, c, depth);
}

void displayFunction(Complex a, Complex c, int depth){
  String s1 = String.format("z(1) = %s", point.toString());
  String s2 = String.format("z(n) = (z(n-1)+%s)^2", c.toString());
  text(s1, 8, 20);
  text(s2, 8, 40);
}

void generatePoints(Complex point, Complex[] points) {
  points[0] = point.squared();
  for(int i = 1; i < depth; i++){
      points[i] = points[i-1].add(c).squared();
  }
}

void plotPoints(Complex[] points) {
  for (int i = 0; i < points.length; i++) {
    plot(points[i].real, points[i].imaginary, 0);
  }
  for (int i = 1; i < points.length; i++) {
    float[] prevCoord = getCoords(points[i-1]);
    float[] coord = getCoords(points[i]);
    strokeWeight(1);
    line(prevCoord[0], prevCoord[1], coord[0], coord[1]);
  }
}

Complex getZ() {
  float r = interval*(mouseX-width/2);
  float i = interval*(height/2-mouseY);
  return new Complex(r, i);
}

float[] getCoords(Complex z){
  float x = z.real/interval+width/2;
  float y = height-(z.imaginary/interval+height/2);
  return new float[]{x, y};
}

void plot(float r, float i, int colour) {
  stroke(colour);
  float[] coords = getCoords(new Complex(r, i));
  strokeWeight(5);
  point(coords[0], coords[1]);
}

void drawAxes(float xInt, float yInt) {
  strokeWeight(1);
  stroke(0);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  float xNum = width/xInt;
  float yNum = height/yInt;
  for (int i = 0; i < xNum; i++) {
    line(i*xInt, height/2-10, i*xInt, height/2+10); 
    float x = (i*xInt-width/2);
    textSize(15);
    fill(0);
    text(String.format("%.3f", x*interval), i*xInt+5, height/2+20);
  }
  for (int i = 0; i < yNum; i++) {
    line(width/2-10, i*yInt, width/2+10, i*yInt); 
    float y = (height/2-i*yInt);
    textSize(15);
    fill(0);
    if (y != 0) {
      text(String.format("%.3fi", y*interval), width/2-60, i*yInt+5);
    }
  }
}
