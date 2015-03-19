final int pointsPerFrame = 100;
final int radius = 1000;
final int numVertices = 6;
final int centerX = radius/2;
final int centerY = 0;
Point randomPoint;

void setup() {
  size(radius,radius);
  background(255);
  stroke(0);
  fill(0);
  frameRate(80);

  // generate a random starting point
  randomPoint = new Point(centerX + int(random(-500, 500)), centerY + int(random(1000)));
  console.log(randomPoint);
}

void draw() {
  // draw {pointsPerFrame} new points
  for (int i=0; i<pointsPerFrame; i++) {
    randomPoint.draw();

    float rando = random();
    if (rando < 0.85) {      // contraction 1
      randomPoint = new Point(
        int(  0.85*randomPoint.x + 0.04*randomPoint.y + 0.00 ),
        int( -0.04*randomPoint.x + 0.85*randomPoint.y + 1.60 )
      );
    }
    else if (rando < 0.92) { // contraction 2
      randomPoint = new Point(
        int( 0.20*randomPoint.x + -0.26*randomPoint.y + 0.00 ),
        int( 0.23*randomPoint.x +  0.22*randomPoint.y + 1.60 )
      );
    }
    else if (rando < 0.99) { // contraction 3
      randomPoint = new Point(
        int( -0.15*randomPoint.x + 0.28*randomPoint.y + 0.00 ),
        int(  0.26*randomPoint.x + 0.24*randomPoint.y + 0.44 )
      );
    }
    else {                   // contraction 4
      randomPoint = new Point(
        int( 0.00*randomPoint.x + 0.00*randomPoint.y + 0.00 ),
        int( 0.00*randomPoint.x + 0.16*randomPoint.y + 0.00 )
      );
    }
  }
  

  if (randomPoint.x < 0) randomPoint.x += width;
  else if (randomPoint.x > width) randomPoint.x -= width;
  if (randomPoint.y < 0) randomPoint.y += height;
  else if (randomPoint.y > height) randomPoint.y -= height;
}

class Point {
  float x, y;
  
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void draw() {
    //ellipse(int(this.x),int(this.y),3,3);
    point(this.x, this.y);
  }
}

