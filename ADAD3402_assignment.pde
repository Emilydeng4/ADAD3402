PVector pos = new PVector(100, 100);

void setup() {
  fullScreen();
  pixelDensity(displayDensity());
  background(0);
  stroke(255);
}

void draw() {
  
}

void mouseClicked(){
  line(pos.x, pos.y, mouseX, mouseY);
  pos = new PVector(mouseX, mouseY);
}
