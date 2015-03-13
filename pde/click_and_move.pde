// globals
float radius = 50.0;
int X, Y;
int nX,nY;
int gX,gY;
int ndelay = 15, gdelay = 30;

// setup the canvas
void setup() {
  size(900, 900);
  strokeWeight(10);
  frameRate(15);
  X = width/2;
  Y = height/2;
  nX = X;
  nY = Y;
}

// main draw loop
void draw() {
  // circle size
  radius = radius + sin(frameCount / 4);
  
  // circle movements
  X += ((nX-X)/ndelay + (gX-X)/gdelay)/2;
  Y += (nY-Y)/ndelay + (gY-Y)/gdelay;
  
  // canvas bg (gray)
  background(100);

  // circle colors
  fill(0, 121, 184);
  stroke(255);

  // draw the circle
  ellipse(X, Y, radius, radius);
}

// set mouse click and movement interaction
void mouseClicked() {
  nX = mouseX;
  nY = mouseY;
}
void mouseMoved() {
  gX = mouseX;
  gY = mouseY;
}

