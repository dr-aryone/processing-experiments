/**
 * source: caseybloomquist.tumblr.com/post/112899784473
 * annotations added; all comments mine
 */

// globals
float radius = 50.0;
int X, Y;
int nX,nY;
int delay = 5;

// setup the canvas
void setup() {
  size(500, 500);
  frameRate(15);
  background(255);
}

void draw() {
  // black circles
  fill(0);
  // no outlines
  noStroke();

  // draw a bunch of circles
  for (int i=0; i<width/2; i++) {
    float s = map(i, 0, width/2, 1, 10);
    
    float y = random(height);
    float mx = 10*s*s*s;
    float x = i - random(mx);

    // determine distance from center of canvas
    float dist = sqrt(pow(x-width/2, 2) + pow(y-height/2, 2));

    // only draw circles that fall within a larger circle
    // centered at the middle of the canvas
    if (dist<width/2) {
      ellipse(x, y, 2, 2);
      ellipse(width - x, height - y, 2, 2);
    }
    else {}
  }
}
