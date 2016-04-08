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
	  console.log("Creating a new spiral:");
	  console.log("\tEquation:\t\tr = %f + %fθ", _a, _b);
	  console.log("\tAngle Step:\t\tθ%cΔ%c = %f", "font-size:.625em", "font-size:inherit", _Dtheta);
    a = _a;
    b = _b;
    Dtheta = _Dtheta;
    
    position = new PolarCoord(0, 0);
  }
  PolarCoord next() {
	  if (b == 0 || step == 0) return null;
    position.th = position.th + Dtheta;
    position.r = a + b*position.th;
    return position;
  }
}


// Global vars
int cx, cy; // the center point of the canvas in cartesian coordinates

// set up the canvas
void setup() {
  background(255);
  //size(W, H);
  size(1200, 1000);
  frameRate(FR);
  smooth();
  
  cx = width/2;
  cy = height/2;
	
  //redrawSpiral(0, PI, PI/2-.05)
}
void draw() { noLoop(); }

void redrawSpiral(a, b, step) {
	if (b==0 || step==0){ console.log("nevermind, got a 0"); return; }
	background(255);
	translate(cx, cy);
  ArchimedianSpiral spiral = new ArchimedianSpiral(a, b, step);
	PVector current = new PVector(0, 0), next = spiral.next();
	float nx = cx, ny = cy;

	while (!(nx < -width || nx > width || ny < -height || ny > height)) {
		nx = next.r * cos(next.th);
		ny = next.r * sin(next.th);
		line(current.x, current.y, nx, ny);
		current = new PVector(nx, ny);
		next = spiral.next();
  }
	translate(-cx, -cy);
}

