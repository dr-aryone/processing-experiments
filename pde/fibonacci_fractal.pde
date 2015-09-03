// see: https://hal.archives-ouvertes.fr/hal-00367972/document

// Constants
int 
  W=1200, // viewport width
  H=1000, // viewport height
  FR=150, // framerate
  STEP=1; // how long of a line segment (in pixels) should be drawn each step 

// Program globals
int
  fibindex=0, // current index within the entire tending-toward-infinity fibonacci word
  segindex=0; // current index within the current fibonacci word segment
float
  theta = 0; // current direction of travel, expressed in radians
String
  fibword1 = "1", fibword2 = "0"; // previous and current word segments
PVector
  position; // current x,y position in the canvas


// generate the next fibonacci word segment when needed
void nextseg() {
	String next = fibword1 + fibword2;
	fibword1 = fibword2;
	fibword2 = next;
	segindex = 0;
}

// setup the canvas
void setup() {
  background(255);
  size(W, H);
  frameRate(FR);
  smooth();
  int cx = width-50*STEP;
  int cy = 50*STEP;
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

// update function; called in draw()
void update() {
  // grab F[n], the nth character from F, the infinite fibonacci string
	char nextChar = fibword2[segindex];

  // if char F[n] is '0':
	if (str(nextChar) == "0") {
    // if n is even, turn left 
		if ((fibindex+1)%2 == 0)
      theta -= HALF_PI;
    // else n is odd; turn right
		else
      theta += HALF_PI;
	}
	
  // increment the segment index and the fibonacci word index
	segindex++;
	fibindex++;
  // if we've reached the end of a word segment, load up the next one
	if (segindex >= fibword2.length) nextseg();
}

