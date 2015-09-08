// based on the following prior work:
//   http://math.bu.edu/DYSYS/arcadia/sect4.html
//   http://math.bu.edu/DYSYS/arcadia/appendix.html

final int pointsPerFrame = 100;
final int WIDTH = 750;
final int HEIGHT = 750;
final int numVertices = 6;
final int centerX = WIDTH/2;
final int pointsPerDraw = 10;
PVector fernPoint;

void setup() {
  size(WIDTH, HEIGHT);
  background(255);
  stroke(0);
  fill(0);
  frameRate(150);

  // generate a random starting point
  //randomPoint = new PVector(centerX + int(random(-500, 500)), centerY + int(random(1000)));
  //fernPoint = new PVector(0, 100);
  
  fernPoint = new PVector(int(random(WIDTH/2)), int(random(HEIGHT/2)));
}

void draw() {
  translate(centerX, height);
  rotate(PI);
  for (int i=0; i<pointsPerDraw; i++) {
    fernTransform(fernPoint);
    point(fernPoint.x*75, fernPoint.y*75);
  }
}

void fernTransform(PVector p) {
  float rand = random(1);
  if (rand < 0.85) firstTransform(p);
  else if (rand >= 0.85 && rand < 0.92) secondTransform(p);
  else if (rand >= 0.92 && rand < 0.97) thirdTransform(p);
  else /*rand >= 0.97 */ fourthTransform(p);
}
void firstTransform(PVector p) {
  p.x = 0.85*p.x + 0.04*p.y;
  p.y = -0.04*p.x + 0.85*p.y + 1.6;
}
void secondTransform(PVector p) {
  p.x = 0.20*p.x - 0.26*p.y;
  p.y = 0.23*p.x + 0.22*p.y + 1.6;
}
void thirdTransform(PVector p) {
  p.x = -0.15*p.x + 0.28*p.y;
  p.y = 0.26*p.x + 0.24*p.y + 0.44;
}
void fourthTransform(PVector p) {
  p.x = 0;
  p.y = 0.16*p.y;
}

