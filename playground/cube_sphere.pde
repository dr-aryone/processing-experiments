float th_x, th_y, dx, dy;
final int BG = 255;

void setup() {
  size(500, 500, OPENGL);
  background(BG);
  th_x = th_y = 0;
  dx = PI/120;
  dy = -PI/240;
  frameRate(65);
}

void draw() {
  background(BG);
  translate(width/2, height/2);
  rotateX(th_x);
  rotateY(th_y);
  box(width/4);
  sphere(width/4*.6);

  th_x += dx;
  th_y += dy;
}


