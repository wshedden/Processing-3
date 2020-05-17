float cubeSize = 80;
int cubeNum = 1;

ArrayList<Cube> cubes = new ArrayList<Cube>();

void setup() {
  size(1000, 600);
  for (int i = 0; i < cubeNum; i++) {
    cubes.add(new Cube(cubeSize));
  }
}

void draw() {
  background(0, 0, 127);
  for (int i = 0; i < cubes.size(); i++) {
    cubes.get(i).update();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    cubes.add(new Cube(cubeSize));
    cubes.get(cubes.size()-1).pos.x = mouseX-cubeSize/2;
    cubes.get(cubes.size()-1).pos.y = mouseY-cubeSize/2;
  }
}
