final int W = 1100, H = 800;
final int BOID_RADIUS = 10;
final int NUM_BOIDS = 100;

Boid[] boids;

void setup() {
  size(W, H);
  frameRate(30);
  boids = new Boid[NUM_BOIDS];
  float boidLength = float(BOID_RADIUS)*3;
  color base = #268bd2,
        alt  = #26d27c;
  float ang = 0;
  for (int i=0; i<NUM_BOIDS; i++) {
    ang += (2*PI)/NUM_BOIDS;
    boids[i] = new Boid(
        W/2 + (W/2-NUM_BOIDS/2)*sin(ang), //*(i/NUM_BOIDS),
        H/2 + (H/2-NUM_BOIDS/2)*cos(ang), //*(i/NUM_BOIDS),
        color(
          red(base)+(red(base)-red(alt))*i/NUM_BOIDS,
          green(base)+(green(alt)-green(base))*i/NUM_BOIDS,
          blue(base)+(blue(alt)-blue(base))*i/NUM_BOIDS
        )
    );
  }
}

void draw() {
  background(#333333);
  
  for (Boid b : boids) {
    b.update();
    b.draw();
  }
}

class Boid {
  float x, y, v;
  color fillColor;
  float th;
  Boid (float _x, float _y, color _color) {
    x = _x;
    y = _y;
    v = 2;
    th = 0;
    fillColor = _color;
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
  
  void update() {
    th = atan2(mouseY-y,mouseX-x) - PI/2;
    /*
    rotate(th);
    x += v;
    rotate(-th);
    if (x > width || x < 0 || y > height || y < 0)
      th += PI;
    */
  }
}

