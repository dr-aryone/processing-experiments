// globals
float cx, cy, radius, circleDiam, thInterval, thIncrease, thIncreaseRads;
int minNumCircles, maxNumCircles;
// setup the canvas
void setup() {
  size(500, 500);
  frameRate(20);
  smooth();
  cx = width/2;
  cy = height/2;
  radius = cx;
  numCircles = 250;
  thIncreaseRads = 2;
}

void drawCircle(x, y) {
  fill(0);
  ellipse(x, y, circleDiam, circleDiam);
}

// main draw loop
void draw() {
  background(255);
  noStroke();

  thInterval = 2*PI/numCircles;
  float tmpx1 = cx+cos(0)*radius,
        tmpy1 = cy+sin(0)*radius,
        tmpx2 = cx+cos(thInterval)*radius,
        tmpy2 = cy+sin(thInterval)*radius;
  circleDiam = sqrt(pow(tmpx2-tmpx1, 2) + pow(tmpy2-tmpy1, 2))*.5;

  thIncreaseRads += .01;
  for (float i=0; i<numCircles; i++) {
    thIncrease = i*radians(thIncreaseRads);
    th = i*thInterval+thIncrease;
    drawCircle(cx+cos(thIncrease)*(radius*(i/numCircles)), cy+sin(th)*(radius*(i/numCircles)));
  }
}

