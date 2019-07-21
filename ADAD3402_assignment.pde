float noiseScale = 0.01, stepSize = 5, totaloffset = 0;
PImage img, backimg;
ArrayList<PVector> curvePoints = new ArrayList<PVector>();

void setup() {
  fullScreen();
  pixelDensity(displayDensity());
  background(0);
  curvePoints.add(new PVector(100, 100));
  curvePoints.add(new PVector(100, 100));
  
  img = loadImage("lildude.png");
  backimg = loadImage("sydmap2.png");
  
  image(backimg, 0, 0, width, height);
}

void draw() {
  tint(255, 30);
  image(backimg, 0, 0, width, height);
  noStroke();
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
      curveVertex(d, enddist*noise((totaloffset + d + frameCount*2)*noiseScale) - enddist/2);
    }
    totaloffset += dist;
    curveVertex(dist, 0);
    curveVertex(dist, 0);
    endShape();
  
    popMatrix();
    pos = newPos;
  }
  
  tint(255, 255);
  image(img, pos.x-30, pos.y-60, 61.8, 125.4);
}

void mouseClicked(){
  curvePoints.add(new PVector(mouseX, mouseY));
}
