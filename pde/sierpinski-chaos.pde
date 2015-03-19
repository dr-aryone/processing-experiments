final int pointsPerFrame = 1000;
Point[] points;
Point randomPoint;

void setup() {
  size(600,600);
  background(255);
  stroke(0);
  points = new Point[3];
  points[0] = new Point(width/2, 0);
  points[1] = new Point(0, height);
  points[2] = new Point(width, height);
  for (Point p : points) {
    p.draw();
  }
  do {
    randomPoint = new Point(int(random(width)), int(random(height)));
  } while (!isInTriangle(randomPoint, points[0], points[1], points[2]));
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

boolean isInTriangle(Point p, Point a, Point b, Point c) {
  return (sameSide(p, a, b, c) && sameSide(p, b, a, c) && sameSide(p, c, a, b));
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

