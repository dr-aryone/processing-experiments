// globals
float radius = 50.0;
int X, Y;
int nX,nY;
int delay = 10;

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
  X += (nX-X)/delay;
  Y += (nY-Y)/delay;
  
  // canvas bg (gray)
  background(100);

  // circle colors
  fill(0, 121, 184);
  stroke(255);

  // draw the circle
  ellipse(X, Y, radius, radius);
}

// set mouse movement interaction
void mouseMoved() {
  nX = mouseX;
  nY = mouseY;
}
