final int pointsPerFrame = 10;
Point[] points;
Point randomPoint;

void setup() {
  size(500,500);
  background(0);
  stroke(255);
  frameRate(80);
  points = new Point[]{ //new Point[3];
    new Point(0, 0),
    new Point(width, 0),
    new Point(width, height),
    new Point(0, height)
  };
  println(points.length);
  for (Point p : points) {
    p.draw();
  }
  do {
    randomPoint = new Point(int(random(width)), int(random(height)));
  } while (!isInPolygon(randomPoint, points));
}

void draw() {
  for (int i=0; i<pointsPerFrame; i++) {
    Point opposite = points[int(random(points.length))],
          halfway  = new Point(
              randomPoint.x+(opposite.x-randomPoint.x)/3,
              randomPoint.y+(opposite.y-randomPoint.y)/3
          );
   halfway.draw();
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

