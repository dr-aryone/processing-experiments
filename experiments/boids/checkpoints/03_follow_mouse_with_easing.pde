final int W = 1100, H = 800;
final int BOID_RADIUS = 10;
final int NUM_BOIDS = 100;
final float BOID_EASING = 0.15;

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
  PVector position, velocity;
  float direction;
  color fillColor;
  Boid (float x, float y, color col) {
    position = new PVector(x, y);
    velocity = new PVector(5,0);
    direction = 0.0;
    fillColor = col;
  }
  
  void update() {
    // turn to face the mosue
    direction = atan2(mouseY-position.y,mouseX-position.x) - PI/2;

    // get distance to mouse
    PVector distance = PVector.sub(new PVector(mouseX, mouseY), position);
    float d = distance.mag();

    float dx = distance.x * BOID_EASING,
          dy = distance.y * BOID_EASING;

    position.x += dx;
    position.y += dy;

    if (position.x > width+BOID_RADIUS)
      position.x = -BOID_RADIUS;
    else if (position.x < -BOID_RADIUS)
      position.x = width + BOID_RADIUS;
    if (position.y > height+BOID_RADIUS)
      position.y = -BOID_RADIUS;
    else if (position.y > height+BOID_RADIUS)
      position.y = height + BOID_RADIUS;
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
    
    translate(position.x,position.y);
    rotate(direction);

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

    rotate(-direction);
    translate(-position.x,-position.y);
  }
}
