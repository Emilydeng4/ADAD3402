float noiseScale = 0.01, stepSize = 5, totaloffset = 0;
PVector pos = new PVector(100, 100);

void setup() {
  fullScreen();
  pixelDensity(displayDensity());
  background(0);
  stroke(255);
  noFill();
}

void draw() {
  
}

void mouseClicked(){
  PVector newPos = new PVector(mouseX, mouseY);
  PVector delta = PVector.sub(newPos,pos);
  float dist = delta.mag();
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(atan2(delta.y, delta.x));
  
  beginShape();  
  curveVertex(0, 0);
  
  for (float d = 0; d < dist; d += stepSize) {
   float enddist = min(min(d*d, (dist-d)*(dist-d)), 300);
   curveVertex(d, enddist*noise((totaloffset + d)*noiseScale) - enddist/2);
  }
  totaloffset += dist;
  curveVertex(dist, 0);
  curveVertex(dist, 0);
  endShape();
  
  popMatrix();
  pos = newPos;
}
