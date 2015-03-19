final int bg = 255;
final int fg = 0;

PImage whole, half;

void setup() {
  size(700,700);
  frameRate(1);
  noStroke();
  
  background(0);

  fill(255);
}
void draw() {
  loadPixels();
  
  for (int i=0; i<height; i+=2)
    for (int j=0; j<width; j+=2)
       pixels[i*width/2+j/2] = pixels[i*width+j];
  updatePixels();
  
  copy(0,0,width/2,height/2, 0,height/2,width/2,height/2);
  rect(0,0,width,height/2);
  copy(0,height/2,width/2,height/2, width/2,height/2,width/2,height/2);
  copy(0,height/2,width/2,height/2, width/4,0,width/2,height/2);

}



