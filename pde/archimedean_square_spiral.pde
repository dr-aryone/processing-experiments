// see https://en.wikipedia.org/wiki/Archimedean_spiral

// Constants
final int 
  W=1200, // viewport width
  H=1000, // viewport height
  FR=150; // framerate
  
final float
  //PI = PI,
  ARCD = PI/16;// how far to rotate around the origin (in radians) for each step of the spiral plot

// Classes
class PolarCoord {
  float r, th;
  PolarCoord (float radius, float theta) {
    r = radius;
    th = theta;
  }
}

class ArchimedianSpiral {
  PolarCoord position;
  float a, b, Dtheta;
  ArchimedianSpiral(float _a, float _b) {
    this(_a, _b, ARCD);
  }
  ArchimedianSpiral(float _a, float _b, float _Dtheta) {
    a = _a;
    b = _b;
    Dtheta = _Dtheta;
    
    position = new PolarCoord(0, 0);
  }
  PolarCoord next() {
    position.th = position.th + Dtheta;
    position.r = a + b*position.th;
    return position;
  }
}


// Global vars
PVector current; // the current position on the cartesian plane at the beginning of the draw interation
int cx, cy; // the center point of the canvas in cartesian coordinates
ArchimedianSpiral spiral; // an iterator that generates a sequence of polar coordinates walking around an archimedian spiral

// set up the canvas
void setup() {
  background(255);
  //size(W, H);
  size(1200, 1000);
  frameRate(FR);
  smooth();
  
  cx = width/2;
  cy = height/2;

	current = new PVector(0, 0);
  spiral = new ArchimedianSpiral(PI*10, 1, PI/2-.05);
}

// main draw loop
void draw() {
	translate(cx, cy);
  PolarCoord next = spiral.next();
  float nx = next.r * cos(next.th),
        ny = next.r * sin(next.th);

	if (nx < -width || nx > width || ny < -height || ny > height) {
		console.log('done!');	
		noLoop();
  }
	else {
		line(current.x, current.y, nx, ny);
		current = new PVector(nx, ny);
	}
}

