final int W = 900, H = 600;
final int BOID_RADIUS = 100;

Boid b;

void setup() {
  size(W, H);
  frameRate(30);
  
  b = new Boid(W/2, H/2, #268bd2);
}

void draw() {
  stroke(200);
  noFill();
  background(#333333);
  rect(0,0,W-2,H-2);
  
  b.update();
  b.draw();
}

class Boid {
  int x, y, color;
  float th;
  Boid (int _x, int _y, int _color) {
    x = _x;
    y = _y;
    color = _color;
    th = 0;
  }
  
  void draw() {
    noStroke();
    fill(color);
    
    arc(x, y, 2*BOID_RADIUS , 2*BOID_RADIUS, 0, 2*PI); // th-PI/4, th+5*PI/4);

    //stroke(255);
    _th = th+PI;

    triangle(
      x+cos(_th-PI/4)*BOID_RADIUS,y+sin(_th-PI/4)*BOID_RADIUS,
      x+cos(_th+5*PI/4)*BOID_RADIUS,y+sin(_th+5*PI/4)*BOID_RADIUS,
      x+cos(_th-PI/2)*BOID_RADIUS*2,y+sin(_th-PI/2)*BOID_RADIUS*2
    );
    /*
    fill(#dc322f);
    text("1", x+cos(th-PI/4)*BOID_RADIUS, y+sin(th-PI/4)*BOID_RADIUS)
    text("2", x+cos(th+5*PI/4)*BOID_RADIUS, y+sin(th+5*PI/4)*BOID_RADIUS)
    text("3", x+cos(th-PI/2)*BOID_RADIUS*2, y+sin(th-PI/2)*BOID_RADIUS*2)
    */
  }
  
  void update() {}
}

// find the two tangent points on a circle corresponding with lines that pass
// through a point outside the circle
// 
// Parameters:
//   cx, cy    center point of the circle
//   r         radius of the circle
//   px, py    point outside the circle
// Return Value:
//   [[t1x, t1y], [t2x, t2y]]  an array of arrays of ints containing the coords
//                             of the two points on the circle that are on the
//                             tangent line with px,py
int[][] tangents(cx, cy, r, px, py) {
  //http://math.stackexchange.com/a/543522/38326
}
