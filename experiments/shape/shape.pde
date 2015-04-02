int cx, cy, r;
float th;
void setup() {
  size(500,500);
  cx = 250;
  cy = 250;
  r  = 50;
  th = 0;
}

void draw() {

  background(51);

  translate(cx,cy);
  rotate(th-PI/2);

  stroke(255);
  fill(180);
  beginShape();

  vertex(-r, -r);  // vp1
  bezierVertex(
      -r*2, r*1.5, // cp1
      r*2,  r*1.5, // cp2
      r, -r        // vp2
  );
  vertex(0,  -r*3);
  vertex(-r, -r);
  endShape();
  
  noStroke();
  fill(#3377ff);
  drawPoint(-r, -r);       // vp1
  drawPoint(r, -r);       // vp2
  fill(#ff7733);
  drawPoint(-r*2, r*1.5); // cp1
  drawPoint(r*2, r*1.5); // cp2
}

void drawPoint(int x, int y) {
  ellipse(x, y, 3, 3);
}

void mouseMoved() {
  int x = mouseX - cx;
  int y = mouseY - cy;
  th = atan2(y,x);
}
