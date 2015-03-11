// globals
float cx, cy, diameter;

// setup the canvas
void setup() {
  size(100, 100);
  smooth();
  cx = width/2;
  cy = height/2;
  diameter = width*.9;
}

// main draw loop
void draw() {
  background(255);
  noStroke();

  // base white circle
  fill(255);
  ellipse(cx, cy, diameter, diameter);
  // base black half-circle
  fill(0);
  arc(cx, cy, diameter, diameter, -PI/2.0, PI/2.0);

  // upper white circle
  fill(255);
  ellipse(cx, cy-diameter/4, diameter/2, diameter/2);
  // lower black circle
  fill(0);
  ellipse(cx, cy+diameter/4, diameter/2, diameter/2);
  
  // lower white circle
  fill(255);
  ellipse(cx, cy+diameter/4, diameter/6, diameter/6);
  // upper black circle
  fill(0);
  ellipse(cx, cy-diameter/4, diameter/6, diameter/6);


  // redo the outline
  noFill();
  stroke(0);
  strokeWeight(2);
  ellipse(cx, cy, diameter, diameter);
}

