// globals
float cx, cy, radius, circleDiam, thInterval;
int minNumCircles, maxNumCircles;
// setup the canvas
void setup() {
  size(500, 500);
  frameRate(60);
  smooth();
  cx = width/2;
  cy = height/2;
  radius = cx*.8;
  minNumCircles = 5;
  maxNumCircles = 500;
  numCircles = minNumCircles;
}

void drawCircle(x, y) {
  fill(0);
  ellipse(x, y, circleDiam, circleDiam);
}

// main draw loop
void draw() {
  background(255);
  noStroke();

  // number of circles ranges from minNumCircles to maxNumCircles
  numCircles = (numCircles - minNumCircles + 1) % maxNumCircles + minNumCircles;
  thInterval = 2*PI/numCircles;
  float tmpx1 = cx+cos(0)*radius,
        tmpy1 = cy+sin(0)*radius,
        tmpx2 = cx+cos(thInterval)*radius,
        tmpy2 = cy+sin(thInterval)*radius;
  circleDiam = sqrt(pow(tmpx2-tmpx1, 2) + pow(tmpy2-tmpy1, 2));

  for (float th=0; th<2*PI; th+=thInterval) {
    drawCircle(cx+cos(th)*radius, cy+sin(th)*radius);
  }
}

