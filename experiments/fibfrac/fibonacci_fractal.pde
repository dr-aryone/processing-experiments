// see: https://hal.archives-ouvertes.fr/hal-00367972/document

// globals
int 
  // Constants
  W=5000, // viewport width
  H=5000, // viewport height
  FR=150, // framerate
  STEP=1, // how long of a line segment should be drawn each step

  // Program variables
  fibindex=0,
  segindex=0;
float theta = 0;
String fibword1 = "1", fibword2 = "0";
PVector position;

// generate the next fibonacci word segment when needed
void nextseg() {
	String next = fibword1 + fibword2;
	fibword1 = fibword2;
	fibword2 = next;
	segindex = 0;
}

// setup the canvas
void setup() {
  size(W, H);
  frameRate(FR);
  smooth();
  int cx = width-100;
  int cy = 100;
	position = new PVector(cx, cy);
}

// main draw loop
void draw() {
  translate(position.x, position.y);
  rotate(theta);
  
	line(0,0, 0,STEP);
  
  PVector move = new PVector(0, STEP);
  move.rotate(theta);
  position.add(move);

	update();
}

// update function
void update() {
	char nextChar = fibword2[segindex];

	if (str(nextChar) == "0") {
		if ((fibindex+1)%2 == 0)
      theta -= HALF_PI;
		else
      theta += HALF_PI;
	}
	
  // increment the segment index and the fibonacci word index
	segindex++;
	fibindex++;
  // if we've reached the end of a word segment, load up the next one
	if (segindex >= fibword2.length) nextseg();
}

