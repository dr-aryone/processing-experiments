final int pointsPerFrame = 1000;
final int radius = 1000;
final int numVertices = 6;
Point[] points;
Point randomPoint;
int frameNum = 0;

void setup() {
  size(radius,radius);
  background(255);
  stroke(255);
  frameRate(80);

  // draw black circle for base
  fill(0);
  strokeWeight(0);
  ellipse(width/2, height/2, width, height);
  strokeWeight(1);

  // generate the points for an n-sided polygon
  points = regularPolygon(numVertices);
  
  // draw the polygon vertices
  for (Point p : points) {
    p.draw();
  }
  // generate a random starting point
  do {
    randomPoint = new Point(int(random(width)), int(random(height)));
  } while (!isInPolygon(randomPoint, points));
}

void draw() {
  // draw {pointsPerFrame} new points
  for (int i=0; i<pointsPerFrame; i++) {
    // pick one of the polygon vertices at random
    Point opposite = points[int(random(points.length))],
    // find the point halfway between your lat point and this vertex
          halfway  = new Point(
              randomPoint.x+(opposite.x-randomPoint.x)/2,
              randomPoint.y+(opposite.y-randomPoint.y)/2
          );
    // draw the halfway point
    halfway.draw();
    // use the halfway point as your point for the next point
    randomPoint = halfway;
  }
}

class Point {
  int x, y;
  
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void draw() {
    point(this.x, this.y);
  }
}

boolean isInPolygon(Point p, Point[] polygon) {
  for (int i=0; i<polygon.length; i++) {
    Point a = polygon[i],
          b = polygon[(i+1)%polygon.length],
          c = polygon[(i+2)%polygon.length];
    if (!sameSide(p, a, b, c)) return false;
  }
  return true;
}

boolean sameSide(Point p1, Point p2, Point a, Point b) {
  PVector ba  = new PVector(b.x-a.x, b.y-a.y),
          p1a = new PVector(p1.x-a.x, p1.y-a.y),
          p2a = new PVector(p2.x-a.x, p2.y-a.y);
  PVector cross1 = ba.cross(p1a),
          cross2 = ba.cross(p2a);
  float dot = cross1.dot(cross2);
  return dot > 0.0;
}

Point[] regularPolygon(int num_sides) {
  int cx = width/2,  //center x
      cy = height/2, //center y
      r  = width/2;  //radius, dist from center to a vertex
  float ang, startAng, centerAng;
  
  centerAng = TWO_PI / num_sides;
  if(num_sides % 2 == 1) // odd number of sides,
    startAng = HALF_PI; // first vertext at 12 o'clock
  else // even number of sides,
    startAng = HALF_PI - centerAng/2; // first two vertices lie along top edge
  
  //create a vertex array
  Point[] vertices = new Point[num_sides];
  for (int i=0; i<num_sides; i++) {
    ang = startAng + (i*centerAng);
    vertices[i] = new Point(
      round(cx + r*cos(ang)),
      round(cy - r*sin(ang))
    );
  }
  return vertices;
}

void mouseClicked() {
  canvasToImg('sketch-canvas');
}
