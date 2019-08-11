float noiseScale = 0.01, stepSize = 5, totaloffset = 0, curveScale = 1;
PImage img, backimg, nobuildimg;
ArrayList<PVector> curvePoints = new ArrayList<PVector>();
int timeout = 1000*10, lastAction = -timeout*2;

void setup() {
  fullScreen(P2D);
  pixelDensity(displayDensity());
  background(0);
  
  img = loadImage("lildude.png");
  backimg = loadImage("sydmap3.png");
  nobuildimg = loadImage("sydmap2.png");
  
  image(nobuildimg, 0, 0, width, height);
}

void draw() {
  tint(255, 30);
  if (millis() - lastAction > timeout) {
    image(nobuildimg, 0, 0, width, height);
    curvePoints.clear();
    textSize(30);
    textAlign(CENTER);
    text("Click to move Emily around", width/2, height/2);
    return;
  }
  image(backimg, 0, 0, width, height);
  
  PVector lastPoint = curvePoints.get(curvePoints.size()-1);
  int lastQuadrant = 1;
  if (width/3 <= lastPoint.x && lastPoint.x < 2*width/3) {
    lastQuadrant = 2;
  } else if (2*width/3 <= lastPoint.x) {
    lastQuadrant = 3;
  }
  if (lastPoint.y >= height/2) {
    lastQuadrant += 3; 
  }
  
  noStroke();
  noFill();
  if (lastQuadrant % 2 == 1) {
    colorMode(HSB, 100);
    stroke(frameCount*0.3 %100, 100, 100);
    colorMode(RGB, 255);
  } else {
    stroke(255);
  }
  
  if (lastQuadrant == 1) {
    totaloffset += 1; 
  }
  
  if (lastQuadrant == 2) {
    curveScale = 1.8; 
  } else {
    curveScale = 1; 
  }
  
  float localoffset = 0;
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
      float enddist = min(min(d*d, (dist-d)*(dist-d)), 300)*curveScale;
      curveVertex(d, enddist*noise((totaloffset + localoffset + d + frameCount*1.4)*noiseScale) - enddist/2);
    }
    localoffset += dist;
    curveVertex(dist, 0);
    curveVertex(dist, 0);
    endShape();
  
    popMatrix();
    pos = newPos;
  }
  
  if (lastQuadrant == 4) {
    colorMode(HSB, 100);
    tint(frameCount*0.3 %100, 100, 100);
    colorMode(RGB, 255);
  } else { 
    tint(255, 255);
  }
  
  float imgscale = 1;
  if (lastQuadrant == 5) {
    imgscale =1-(millis()*1.0-lastAction)/timeout;
  }
  pushMatrix();
  translate(pos.x, pos.y);
  if (lastQuadrant == 6) {
    rotate(frameCount*0.04);
  }
  image(img, -30*imgscale, -60*imgscale, 61.8*imgscale, 125.4*imgscale);
  popMatrix();
}

void mouseClicked(){
  lastAction = millis();
  curvePoints.add(new PVector(mouseX, mouseY));
  if (curvePoints.size() > 5) {
    float dist = curvePoints.get(0).dist(curvePoints.get(1));
    totaloffset += dist;
    curvePoints.remove(0); 
  }
}
