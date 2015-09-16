float th_x, th_y, dx, dy;
final int BG = 0;
final float SCALE=100;

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
  
  lights();
  spotlight(
    255, 255, 255,              // color
    3*SCALE, 3*SCALE, 3*SCALE,  // position
    0, 0, 0,                    // direction
    PI/2,                       // angle
    2                           // concentration
  );


  translate(width/2, height/2);
  rotateX(th_x);
  rotateY(th_y);

  beginShape();

  // right trap
  vertex( 1*SCALE,  1  *SCALE,  1*SCALE); // 1
  vertex( 1*SCALE,  0.5*SCALE, -1*SCALE); // 2
  vertex( 1*SCALE, -0.5*SCALE, -1*SCALE); // 3
  vertex( 1*SCALE, -1  *SCALE,  1*SCALE); // 4
  vertex( 1*SCALE,  1  *SCALE,  1*SCALE); // 1

  // back rect
  vertex(-1*SCALE,  1  *SCALE,  1*SCALE); // 6
  vertex(-1*SCALE,  0.5*SCALE, -1*SCALE); // 7
  vertex( 1*SCALE,  0.5*SCALE, -1*SCALE); // 2
  vertex( 1*SCALE,  1  *SCALE,  1*SCALE); // 1

  // left trap
  vertex(-1*SCALE,  1  *SCALE,  1*SCALE); // 6
  vertex(-1*SCALE,  0.5*SCALE, -1*SCALE); // 7
  vertex(-1*SCALE, -0.5*SCALE, -1*SCALE); // 8
  vertex(-1*SCALE, -1  *SCALE,  1*SCALE); // 5
  vertex(-1*SCALE,  1  *SCALE,  1*SCALE); // 6

  // top rect
  vertex(-1*SCALE, -1  *SCALE,  1*SCALE); // 5
  vertex( 1*SCALE, -1  *SCALE,  1*SCALE); // 4
  vertex( 1*SCALE,  1  *SCALE,  1*SCALE); // 1
  vertex(-1*SCALE,  1  *SCALE,  1*SCALE); // 6

  // bottom rect
  vertex(-1*SCALE,  0.5*SCALE, -1*SCALE); // 7
  vertex( 1*SCALE,  0.5*SCALE, -1*SCALE); // 2
  vertex( 1*SCALE, -0.5*SCALE, -1*SCALE); // 3
  vertex(-1*SCALE, -0.5*SCALE, -1*SCALE); // 8
  
  // front rect
  vertex( 1*SCALE, -0.5*SCALE, -1*SCALE); // 3
  vertex( 1*SCALE, -1  *SCALE,  1*SCALE); // 4
  vertex(-1*SCALE, -1  *SCALE,  1*SCALE); // 5
  vertex(-1*SCALE, -0.5*SCALE, -1*SCALE); // 8

  // return home
  vertex( 1*SCALE, -0.5*SCALE, -1*SCALE); // 3
  vertex( 1*SCALE,  0.5*SCALE, -1*SCALE); // 2

  endShape(CLOSE);

  th_x += dx;
  th_y += dy;
}


