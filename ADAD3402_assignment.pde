float noiseScale = 0.01, stepSize = 5, totaloffset = 0;

ArrayList<PVector> curvePoints = new ArrayList<PVector>();

void setup() {
  fullScreen();
  pixelDensity(displayDensity());
  background(0);
  curvePoints.add(new PVector(100, 100));
  curvePoints.add(new PVector(100, 100));
}

void draw() {
  fill(0, 30);
  noStroke();
  rect(0, 0, width, height);
  noFill();
  stroke(255);
  
  totaloffset = 0;
  PVector pos = curvePoints.get(0);
  for (int i = 1; i < curvePoints.size();  i++) {
    PVector newPos = curvePoints.get(i);
    PVector delta = PVector.sub(newPos, pos);
    float dist = delta.mag();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(atan2(delta.y, delta.x));
  
    beginShape();  
    curveVertex(0, 0);
    
    for (float d = 0; d < dist; d += stepSize) {
      float enddist = min(min(d*d, (dist-d)*(dist-d)), 300);
      curveVertex(d, enddist*noise((totaloffset + d + frameCount)*noiseScale) - enddist/2);
    }
    totaloffset += dist;
    curveVertex(dist, 0);
    curveVertex(dist, 0);
    endShape();
  
    popMatrix();
    pos = newPos;
  }
  
}

void mouseClicked(){
  curvePoints.add(new PVector(mouseX, mouseY));
}
