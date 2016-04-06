// see https://en.wikipedia.org/wiki/Archimedean_spiral

// Constants
final int 
  W=1200, // viewport width
  H=1000, // viewport height
  FR=150; // framerate
  
final float
  π = PI,
	ARCΔ = π/16;// how far to rotate around the origin (in radians) for each step of the spiral plot

// Classes
class PolarCoord {
	float r, θ;
	PolarCoord (float radius, float theta) {
		r = radius;
		θ = theta;
	}
}

function* archimedianSpiral(a, b, Δθ=ARCΔ) {
	PolarCoord position = new PolarCoord(origin.r, origin.θ);
	while (true) {
		position.θ = (position.θ + Δθ) % 2*π;
		position.r = a + b*position.θ;
		yield position;
	}
}


// Global vars
PVector current; // the current position on the cartesian plane at the beginning of the draw interation
int cx, cy; // the center point of the canvas in cartesian coordinates
var spiral; // an interator that generates a sequence of polar coordinates walking around an archimedian spiral

// set up the canvas
void setup() {
  background(255);
  size(W, H);
  frameRate(FR);
  smooth();
	
  int cx = width/2;
  int cy = height/2;

	archimedianSpiral(1, 2)
}

// main draw loop
void draw() {
	PolarCoord next = spiral.next();
	float nx = next.r * cos(next.θ),
			  nx = next.r * sin(next.θ);
	
	// necessary?
  translate(cx, cy);
  
	line(current.x, current.y, nx, ny);
	current = new PVector(nx, ny);
}

