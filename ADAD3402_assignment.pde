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
  PVector newPos = new PVector(mouseX, mouseY);
  PVector delta = PVector.sub(newPos,pos);
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(atan2(delta.y, delta.x));
  line(0, 0, delta.mag(), 0);
  popMatrix();
  pos = newPos;
}
