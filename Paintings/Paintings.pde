int interval = 1;
PImage image;
int tick = 0;
int background;
String[] images = new String[]{"garden.jpg", "gogh.jpg", "sunrise.jpg", "night.jpg"};
int nImage = 0;
int tickInterval;
void setup() {
  size(1200, 675);
  image = loadImage(images[nImage]);
  background = averageColour(image.pixels);
  tickInterval = image.width/350;
  interval = 1;
}

void updateImage(){
  int[] p = image.pixels;
  for(int i = 0; i < p.length-interval; i+=interval){
      for(int k = 0; k < interval; k++){
         p[i+k] = random(1) < 0.9 ? p[i+k] : p[i];   
      }
  }
  image.pixels = p;
  image.updatePixels();
}

int averageColour(int[] p){
  double[] c = new double[]{0, 0, 0};
  int l = p.length;
  for(int i = 0; i < l; i++){
      c[0] += (double)red(p[i])/(double) l;
      c[1] += (double)green(p[i])/(double) l;
      c[2] += (double)blue(p[i])/(double) l;
  }
  return color((int) c[0], (int) c[1], (int) c[2]);
}

void draw() {
  scale(min(width/(float)image.width, height/(float)image.height));
  tick++;
  background(background);
  image(image, 0, 0);
  if(tick % tickInterval == 0) interval++;
  updateImage();
}

void mousePressed(){
   nImage = (nImage + 1) % images.length;
   setup();
}

void keyPressed(){
    save("image.jpg");
}
