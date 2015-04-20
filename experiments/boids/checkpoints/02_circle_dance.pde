final int W = 1100, H = 800;
final int BOID_RADIUS = 10;
final int NUM_BOIDS = 100;

Boid boid;

void setup() {
  size(W, H);
  frameRate(30);
  color base = #268bd2;
  boid = new Boid(W/2, H/2, base);
}

void draw() {
  background(#333333);
  
  boid.update();
  boid.draw();
}

class Boid {
  float x, y, v;
  color fillColor;
  float th;
  Boid (float _x, float _y, color _color) {
    x = _x;
    y = _y;
    v = 5;
    th = 0;
    fillColor = _color;
  }
  
  void update() {
    th = atan2(mouseY-y,mouseX-x) - PI/2;

    float dx = v*cos(th),
          dy = v*sin(th);
    stroke(red);
    line(x,y, x+dx,y+dy);

    x += dx;
    y += dy;

    if (x > width+BOID_RADIUS)
      x = -BOID_RADIUS;
    else if (x < -BOID_RADIUS)
      x = width + BOID_RADIUS;
    if (y > height+BOID_RADIUS)
      y = -BOID_RADIUS;
    else if (y > height+BOID_RADIUS)
      y = height + BOID_RADIUS;
  }
  
  void draw() {
    fill(fillColor);
    stroke(
      color(
        red(fillColor)*.875,
        green(fillColor)*.875,
        blue(fillColor)*.875
      )
    );
    
    translate(x,y);
    rotate(th);

    beginShape();
    vertex(-BOID_RADIUS, -BOID_RADIUS);
    bezierVertex(
        -BOID_RADIUS*2, BOID_RADIUS*1.5,
        BOID_RADIUS*2,  BOID_RADIUS*1.5,
        BOID_RADIUS, -BOID_RADIUS       
    );
    vertex(0,  -BOID_RADIUS*3);
    vertex(-BOID_RADIUS, -BOID_RADIUS);
    endShape();

    rotate(-th);
    translate(-x,-y);
  }
}

