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
    //stroke(255);
    fill(color);
    
    arc(x, y, 2*BOID_RADIUS , 2*BOID_RADIUS, th-PI/4, th+5*PI/4);
    triangle(x+cos(th-PI/4)*BOID_RADIUS,y+sin(th-PI/4)*BOID_RADIUS, x-cos(th+5*PI/4)*BOID_RADIUS,y-sin(th+5*PI/4)*BOID_RADIUS, x+cos(th-PI/2)*BOID_RADIUS*2,y+sin(th-PI/2)*BOID_RADIUS*2);
  }
  
  void update() {}
}
