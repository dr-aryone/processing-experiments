// Music Box with Inlaid Hilbert Curve and J holes - Jim Bumgardner, 2011

// Produces 72 DPI PDF

// Final pattern is 10.5 x 10.75
// Music boxeis 5.5 x 5.5 x 2.25

import processing.pdf.*;

boolean outputPDF = false; // set this to true to produce a PDF file

String axiom = "A";
String[] rules = {"A", "lBfrAfArfBl",
                  "B", "rAflBfBlfAr"};

int nbrGenerations = 4;
String lsys;
String lsys2;

float woodInch = 72;

float woodWidth = woodInch*12;
float woodHeight = woodInch*12;

float margin = woodInch*.5;
float mx = margin;
float my = margin;

float boxW = (woodHeight-margin*2)/2.0;
float boxH = boxW;

float edgeW = woodHeight*.25/12; // quarter inch puzzle edges

void setup()
{
  println("EdgeW = " + edgeW);
  size((int) woodWidth, (int) woodHeight);
  noLoop();

  lsys = lsysGen(axiom,rules, nbrGenerations);
  lsys2 = lsysGen(axiom,rules, nbrGenerations+1);

  println("Full Design Height in Inches: " + (boxH*2.0-woodInch/4)/woodInch);
  println("Full Design Width in Inches: " +  (boxW*2.0-woodInch/2)/woodInch);
}

String lsysGen(String lsys, String[] rules, int nbrGenerations)
{
  while (nbrGenerations > 0) {
    String dst = "";
    for (int i = 0; i < lsys.length(); ++i) {
      String ch = lsys.substring(i,i+1);
      boolean gotMatch = false;
      for (int j = 0; j < rules.length; j += 2) {
        if (ch.equals(rules[j])) {
          dst += rules[j+1];
          gotMatch = true;
          break;
        }
      }
      if (!gotMatch) {
         dst += ch;
      }
    }
    println(dst);
    lsys = dst;
    --nbrGenerations; // 1 down
  }
  return lsys;
}

class Cell {
  int  x,y;
  Cell(int x, int y) {
    this.x = x;
    this.y = y;
  }
  String getKey() {
    return makeKey(x,y);
  }
  
  String makeKey(int x, int y) {
    return x + ":" + y;
  }
}

class Segment {
  float  x1,y1, x2,y2;
  Segment(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
}


HashMap lsysProduceCells(String lsys) 
{
  float px = .5;
  float py = .5;
  int   angD = 0;

  HashMap cells = new HashMap();
  Cell cell = new Cell(floor(px), floor(py));
  cells.put(cell.getKey(), cell);
  beginShape();
  vertex(px,py);
  
  for (int i = 0; i < lsys.length(); ++i) {
     char ch = lsys.charAt(i);
     if (ch == 'f') {
       px += cos(radians(angD));
       py += sin(radians(angD));
       cell = new Cell(floor(px), floor(py));
       cells.put(cell.getKey(), cell);
       px += cos(radians(angD));
       py += sin(radians(angD));
       cell = new Cell(floor(px), floor(py));
       cells.put(cell.getKey(), cell);
     }
     else if (ch == 'l') {
       angD -= 90;
     }
     else if (ch == 'r') {
       angD += 90;
     }
  }
  return cells;
}

// Simple Cell Drawing
void drawCells(HashMap cells, float ox, float oy, float pw, float ph)
{
  println("Produced " + cells.size() + " cells"); // 1,4,16,64,256,1024  4^nbrGenerations
  int minX=10000,maxX=-10000,minY=10000,maxY=-10000;
  Iterator i = cells.entrySet().iterator();  // Get an iterator
  while (i.hasNext()) {
    Cell cell = (Cell) ((Map.Entry)i.next()).getValue();
    minX = min(minX,cell.x);
    maxX = max(maxX,cell.x);
    minY = min(minY,cell.y);
    maxY = max(maxY,cell.y);
  }
  int gw = maxX+1-minX; // pow(2,nbrGenerations+1)-1
  int gh = maxY+1-minY;
  println("Produced " + cells.size() + " cells"); // 1,4,16,64,256,1024  4^nbrGenerations
  println(minX+","+minY+"  -->  "+maxX+","+maxY); // 0,-W, W,0
  println("Width : " + gw);  
  println("Height: " + gh);
  float cw = pw / (float) gw;
  float ch = ph / (float) gh;
  noStroke();
  fill(0);
  i = cells.entrySet().iterator();  // Get an iterator
  while (i.hasNext()) {
    Cell cell = (Cell) ((Map.Entry)i.next()).getValue();
    // println("Drawing " + cell.x + "," + cell.y);
    float px = ox+(cell.x - minX)*cw;
    float py = oy+(cell.y - minY)*ch;
    rect(px, py, cw, ch);
  }
}

Segment GetTailMatch(ArrayList lst, Segment src) 
{
  for (int idx = 0; idx < lst.size(); ++idx) {
    Segment seg = (Segment) lst.get(idx);
    if (abs(seg.x1-src.x2) < .2 && abs(seg.y1-src.y2) < .2) {
        return seg;
    }
  }
  return null;
}

// Complex Cell Drawing
// Do it as a series of straight lines and curved corners.
void drawCellVectors(HashMap cells, float ox, float oy, float pw, float ph, boolean useFill)
{
  int minX=10000,maxX=-10000,minY=10000,maxY=-10000;
  Iterator i = cells.entrySet().iterator();  // Get an iterator
  while (i.hasNext()) {
    Cell cell = (Cell) ((Map.Entry)i.next()).getValue();
    minX = min(minX,cell.x);
    maxX = max(maxX,cell.x);
    minY = min(minY,cell.y);
    maxY = max(maxY,cell.y);
  }
  int gw = maxX+1-minX;
  int gh = maxY+1-minY;
  float cw = pw / (float) gw;
  float ch = ph / (float) gh;

  ArrayList  llist = new ArrayList();

  i = cells.entrySet().iterator();  // Get an iterator
  while (i.hasNext()) {
    Cell cell = (Cell) ((Map.Entry)i.next()).getValue();

    if (!cells.containsKey(cell.makeKey(cell.x-1,cell.y))) {
       // LL straight
       llist.add(new Segment(cell.x,cell.y+1,cell.x,cell.y+.5)); // lower left
       // UL straight
       llist.add(new Segment(cell.x,cell.y+.5,cell.x,cell.y)); // upper left 
    }
    if (!cells.containsKey(cell.makeKey(cell.x+1,cell.y))) {
       // UR straight
       llist.add(new Segment(cell.x+1,cell.y,cell.x+1,cell.y+.5)); // upper right 
       // UR straight
       llist.add(new Segment(cell.x+1,cell.y+.5,cell.x+1,cell.y+1)); // lower right
    }

    if (!cells.containsKey(cell.makeKey(cell.x,cell.y-1))) {
       // UL straight
       llist.add(new Segment(cell.x,cell.y,cell.x+.5,cell.y)); // left top 
       // LL straight
       llist.add(new Segment(cell.x+.5,cell.y,cell.x+1,cell.y)); // right top
    }
    if (!cells.containsKey(cell.makeKey(cell.x,cell.y+1))) {
       // LL straight
       llist.add(new Segment(cell.x+1,cell.y+1,cell.x+.5,cell.y+1)); // right bot
       // UL straight
       llist.add(new Segment(cell.x+.5,cell.y+1,cell.x,cell.y+1)); // left bot 
    }

  }

  ArrayList eloop = new ArrayList();
  
  // Construct sorted lists...
  Segment curSeg = (Segment) llist.get(0);
  eloop.add( curSeg );  llist.remove( llist.indexOf(curSeg) );
  Segment matSeg = null;
  while ((matSeg = GetTailMatch(llist, curSeg)) != null) {
    eloop.add(matSeg); llist.remove( llist.indexOf(matSeg));
    curSeg = matSeg;
  }

  if (!useFill) {
    noFill();
    stroke(0);
    strokeWeight(.25);
  }
  else {
    fill(255,0,0);
    noStroke();
  }
  beginShape();
  Segment seg = (Segment) eloop.get(0);
  vertex(ox+(seg.x2-minX)*cw, oy+(seg.y2-minY)*ch);
  int lSize = eloop.size();
  for (int idx = 1; idx <= lSize; idx += 2) {
    seg = (Segment) eloop.get(idx % lSize);
    Segment nSeg = (Segment) eloop.get((idx+1) % lSize);
    if (abs(seg.x1-seg.x2) != abs(nSeg.x1-nSeg.x2)) {

//      vertex(ox+(seg.x2-minX)*cw, oy+(seg.y2-minY)*ch);
//      vertex(ox+(nSeg.x2-minX)*cw, oy+(nSeg.y2-minY)*ch);

      bezierVertex(// ox+(seg.x1-minX)*cw, oy+(seg.y1-minY)*ch,
//             (ox+(seg.x2-minX)*cw + ox+(seg.x1-minX)*cw)/2, (oy+(seg.y2-minY)*ch + oy+(seg.y1-minY)*ch )/2,
//             (ox+(nSeg.x1-minX)*cw + ox+(nSeg.x2-minX)*cw)/2, (oy+(nSeg.y1-minY)*ch + oy+(nSeg.y2-minY)*ch)/2,
             ox+(seg.x2-minX)*cw,  oy+(seg.y2-minY)*ch,
             ox+(nSeg.x1-minX)*cw, oy+(nSeg.y1-minY)*ch,
             ox+(nSeg.x2-minX)*cw, oy+(nSeg.y2-minY)*ch); 
    }  else {
      vertex(ox+(nSeg.x2-minX)*cw, oy+(nSeg.y2-minY)*ch);
    } 
  }
  endShape(); 
}

void boxedges(float x, float y, float w, float h, int topType, int rightType, int botType, int leftType)
{
  int  nbrHTags = (int) floor(w/edgeW);
  int  nbrVTags = (int) floor(h/edgeW);
  // fill(0xcc);

  if (topType != -1) {
    int topFlag = topType & 8;
    topType &= ~8;
    beginShape();
    for (int i = 0; i < nbrHTags; i++) {
      if (i < nbrHTags-1 && topFlag == 8)
        continue;
      if (i == 0)
        continue;
      boolean in = (i+(topType==2? 1 : 0)) % 2 == 1;
      if ((i == 0 && topType == 1) || (i == nbrHTags-1 && topType == 0))  in = !in;
      if (topType >= 2 && (i < 1 || i >= nbrHTags-2))  in = true;
      if (i == 0 || i == nbrHTags-1)  in = false; // corner
      if (in) {
        vertex(x+(nbrHTags-i)*edgeW, y);
        vertex(x+(nbrHTags-i)*edgeW-edgeW, y);
      } else {
        vertex(x+(nbrHTags-i)*edgeW, y+edgeW);
        vertex(x+(nbrHTags-i)*edgeW-edgeW, y+edgeW);
      }
    }      
    endShape();
  }
  
  if (botType != -1) {
    beginShape();
    for (int i = 0; i < nbrHTags; i++) {
      boolean in = (i+(botType==2? 1 : 0)) % 2 == 1;
      if (i == 0)
        continue;
      if ((i == 0 && botType == 1) || (i == nbrHTags-1 && botType == 0))  in = !in;
      if (botType == 3 && i == 1) in = !in;
      if (botType >= 2 && (i < 1 || i > nbrHTags-2))  in = true;
      if (i == 0 || i == nbrHTags-1)  in = false; // corner
      if (in) {
        vertex(x+i*edgeW, y+h);
        vertex(x+i*edgeW+edgeW, y+h);
      } else {
        vertex(x+i*edgeW, y+h-edgeW);
        vertex(x+i*edgeW+edgeW, y+h-edgeW);
      }
    }      
    endShape();
  }

  if (leftType != -1) {
    int leftFlag = leftType & 8;
    leftType &= ~8;

    beginShape();
    for (int i = 0; i < nbrVTags; i++) {
      if (i == 0 && leftType == 1)
        continue;
      if (i == 0 && leftFlag == 8)
        continue;
      if (i == nbrVTags-1 && leftType == 0)
        continue;
      boolean in = i % 2 == 1;
      if ((i == 0 && leftType == 1) || (i == nbrVTags-1 && leftType == 0))  in = !in;
      if (i == 0 || i == nbrVTags-1)  in = false; // corner
      if (in) {
        vertex(x,y+i*edgeW);
        vertex(x,y+i*edgeW+edgeW);
      } else {
        vertex(x+edgeW,y+i*edgeW);
        vertex(x+edgeW,y+i*edgeW+edgeW);
      }
    }      
    endShape();
  }

  if (rightType != -1) {
    int rightFlag = rightType & 8;
    rightType &= ~8;

    beginShape();
    for (int i = 0; i < nbrVTags; i++) {
      if (i == 0)
        continue;
      if (i < nbrVTags-1 && rightFlag == 8)
        continue;
      boolean in = i % 2 == 1;
      if ((i == 0 && rightType == 1) || (i == nbrVTags-1 && rightType == 0))  in = !in;
      if (i == 0 || i == nbrVTags-1)  in = false; // corner
      if (in) {
        vertex(x+w,y+(nbrVTags-i)*edgeW);
        vertex(x+w,y+(nbrVTags-i)*edgeW-edgeW);
      } else {
        vertex(x+w-edgeW,y+(nbrVTags-i)*edgeW);
        vertex(x+w-edgeW,y+(nbrVTags-i)*edgeW-edgeW);
      }
    }      
    endShape();
  }
  noFill();
}

void draw()
{
  background(251,237,238);

  if (outputPDF)
     beginRecord(PDF, "hillbert_box_final_2.pdf");

  strokeWeight(0.25);
  if (outputPDF)  stroke(0);
  else            stroke(53,35,25);
  noFill();
  smooth();

  // Top
  boxedges(mx,my,boxW,boxH,1,9,1,1);
  // Bottom
  boxedges(mx,my+boxH-woodInch/4,boxW,boxH,9,9,1,1);

  // Edges
  for (int gy = 0; gy < 2; ++gy) {
    for (int gx = 0; gx < 2; ++gx) {
      boxedges(mx+boxW+(boxW/2)*gx-(woodInch/4)*(1+gx),my+boxH*gy-(gy==1? woodInch/4 : 0),boxW/2.0,boxH, 
          gy==1? -1 : 3,
          gx==0? 8 : 0,
          2,
          gy==0? 8 : 0);
    }
  }

  // Crank Hole - centered 1 inch above floor of box
  ellipse(mx+boxW+boxW/2-woodInch-(woodInch/4), my+woodInch, woodInch*.4, woodInch*.4);
  
  float rad = (boxW*7/8.0)/2.0;

  float lineLength = rad * pow(.5, nbrGenerations-1);

  HashMap cells = lsysProduceCells(lsys);
  float margin = 3*boxW/(pow(2,nbrGenerations+1)-1);

  drawCellVectors(cells, mx+margin, my+margin, boxH-margin*2, boxH-margin*2, false );

  HashMap cells2 = lsysProduceCells(lsys2);
  drawCellVectors(cells2, mx+margin, my+boxH+margin-woodInch/4, boxH-margin*2, boxH-margin*2, true );

  fill(0);
  // drawCellVectors(cells, mx+boxW*3+margin, my+margin, boxH-margin*2, boxH-margin*2, true );
  // drawCellVectors(cells, mx+boxW*3+margin, my+boxH+margin, boxH-margin*2, boxH-margin*2, true );

  lsys = lsysGen(axiom,rules, nbrGenerations-1);
  cells = lsysProduceCells(lsys);
  float hmargin = 1.5*boxW/(pow(2,nbrGenerations)-1);
  float vmargin = 1.5*boxW/(pow(2,nbrGenerations)-1);

  noFill();
  stroke(0);
  strokeWeight(0.25);
  for (int gy = 0; gy < 2; ++gy) {
    for (int gx = 0; gx < 2; ++gx) {
      drawJ(mx+boxW+(boxW/2)*gx+hmargin-(woodInch/4)*(1+gx), my+boxH*gy+vmargin+boxH/4-(gy==1? woodInch/4 : 0),boxW/2.0-hmargin*2, boxH/4);
      // drawCellVectors(cells, mx+boxW+(boxW/2)*gx+hmargin,my+boxH*gy+vmargin,boxW/2.0-hmargin*2,boxH-vmargin*2);
    }
  }
  if (outputPDF) {
    endRecord();
    exit();
  }
  save("hilbert.png");
}

// The letter J came from the Zapf Chancery Bold font, I used
// the Geomerative library to convert it to processing code.
//
void drawJ(float x, float y, float w, float h) 
{
  pushMatrix();
  translate(x,y);
  scale(w/101.0);
  translate(0,12);


  beginShape();
  vertex(33.532307,33.609913);
  vertex(33.532291,33.609928);
  vertex(38.572292,44.553928); // B
  vertex(38.572292,50.313927); // B
  bezierVertex(38.284336,50.409958,37.996338,50.505955,37.708294,50.601929); // B
  bezierVertex(37.324341,50.697960,36.940338,50.793953,36.556293,50.889931); // B
  bezierVertex(36.268341,50.985958,35.932339,51.081955,35.548294,51.177929); // B
  bezierVertex(35.164341,51.273956,34.780342,51.321953,34.396294,51.321930); // B
  bezierVertex(34.108341,51.417957,33.820343,51.513954,33.532295,51.609928); // B
  bezierVertex(33.148346,51.705948,32.764347,51.753952,32.380295,51.753929); // B
  bezierVertex(31.996346,51.753952,31.660347,51.753952,31.372295,51.753929); // B
  bezierVertex(30.988348,51.753952,30.604349,51.753952,30.220295,51.753929); // B
  bezierVertex(27.244350,51.753952,24.508354,51.417953,22.012295,50.745926); // B
  bezierVertex(19.516359,50.073952,17.212360,49.017956,15.100295,47.577927); // B
  bezierVertex(13.084365,46.233959,11.212367,44.553959,9.484296,42.537930); // B
  bezierVertex(7.756371,40.521965,6.268373,38.169968,5.020296,35.481930); // B
  bezierVertex(4.252374,33.849972,3.580375,32.217972,3.004296,30.585930); // B
  bezierVertex(2.428376,28.857979,1.996376,27.081978,1.708295,25.257931); // B
  bezierVertex(1.420377,23.529984,1.228377,21.801987,1.132295,20.073929); // B
  bezierVertex(0.940377,18.249989,0.796378,16.425987,0.700295,14.601929); // B
  bezierVertex(0.700378,14.217991,0.700378,13.881992,0.700295,13.593929); // B
  bezierVertex(0.700378,13.209991,0.652378,12.825996,0.556295,12.441933); // B
  bezierVertex(0.556378,12.057999,0.556378,11.722000,0.556295,11.433929); // B
  bezierVertex(0.556378,11.049995,0.556378,10.665993,0.556295,10.281929); // B
  vertex(0.556295,4.521927); // B
  bezierVertex(0.556378,3.753998,0.556378,3.033997,0.556295,2.361923); // B
  bezierVertex(0.556378,1.594002,0.556378,0.874001,0.556295,0.201920); // B
  vertex(4.588295,4.809921); // B
  vertex(56.140293,17.049919); // B
  bezierVertex(57.004318,17.241978,57.820316,17.433979,58.588295,17.625919); // B
  bezierVertex(59.260319,17.721981,59.884319,17.865978,60.460297,18.057919); // B
  bezierVertex(61.132320,18.153980,61.756317,18.297977,62.332298,18.489918); // B
  bezierVertex(62.908318,18.585979,63.484318,18.729977,64.060303,18.921917); // B
  bezierVertex(64.636314,19.017979,65.212318,19.161976,65.788300,19.353916); // B
  bezierVertex(66.364319,19.545975,66.892319,19.689972,67.372299,19.785915); // B
  bezierVertex(67.852318,19.977970,68.332314,20.169971,68.812302,20.361916); // B
  bezierVertex(69.292313,20.457977,69.772316,20.601971,70.252304,20.793915); // B
  bezierVertex(71.116318,21.177971,71.980316,21.609970,72.844307,22.089916); // B
  bezierVertex(73.708321,22.473969,74.524315,22.905968,75.292305,23.385918); // B
  bezierVertex(75.676315,23.673969,76.060310,23.961971,76.444305,24.249916); // B
  bezierVertex(76.828308,24.441967,77.164314,24.681969,77.452309,24.969917); // B
  bezierVertex(77.836311,25.257969,78.220314,25.593967,78.604309,25.977917); // B
  bezierVertex(78.988312,26.265968,79.372314,26.601967,79.756310,26.985916); // B
  bezierVertex(80.428314,27.657967,81.148308,28.425964,81.916313,29.289917); // B
  bezierVertex(82.684311,30.057964,83.452316,30.969963,84.220314,32.025917); // B
  vertex(94.732315,45.417915); // B
  bezierVertex(95.596306,46.761948,96.364304,48.153946,97.036316,49.593918); // B
  bezierVertex(97.804298,51.033943,98.428299,52.473942,98.908318,53.913918); // B
  bezierVertex(99.388298,55.353939,99.724304,56.889938,99.916321,58.521919); // B
  bezierVertex(100.204308,60.057934,100.348297,61.641933,100.348320,63.273918); // B
  vertex(100.492317,69.033920); // B
  vertex(99.772316,76.521919); // B
  vertex(90.124313,70.905914); // B
  vertex(90.124313,65.145920); // B
  bezierVertex(90.028305,65.049927,89.980309,64.953926,89.980316,64.857918); // B
  bezierVertex(89.980309,64.761925,90.028305,64.617928,90.124313,64.425919); // B
  bezierVertex(90.124306,64.329926,90.124306,64.233932,90.124313,64.137917); // B
  bezierVertex(90.124306,63.945930,90.124306,63.801929,90.124313,63.705917); // B
  bezierVertex(90.124306,63.513931,90.124306,63.369930,90.124313,63.273918); // B
  bezierVertex(90.124306,63.177925,90.172302,63.033928,90.268311,62.841915); // B
  bezierVertex(90.268303,62.745926,90.268303,62.649929,90.268311,62.553917); // B
  bezierVertex(90.364304,62.361931,90.412300,62.217930,90.412308,62.121918); // B
  bezierVertex(90.412300,61.929932,90.412300,61.737930,90.412308,61.545914); // B
  bezierVertex(90.412300,61.353931,90.460297,61.161930,90.556305,60.969917); // B
  bezierVertex(90.556297,60.873936,90.556297,60.777931,90.556305,60.681915); // B
  bezierVertex(90.556297,60.585938,90.604294,60.489929,90.700302,60.393913); // B
  bezierVertex(90.700294,60.297935,90.700294,60.201931,90.700302,60.105915); // B
  bezierVertex(90.700294,60.009933,90.700294,59.913933,90.700302,59.817917); // B
  bezierVertex(90.700294,59.337933,90.700294,58.905930,90.700302,58.521915); // B
  bezierVertex(90.796295,58.041931,90.892296,57.609932,90.988304,57.225914); // B
  bezierVertex(90.700294,54.153938,89.932297,51.465942,88.684303,49.161915); // B
  bezierVertex(87.436302,46.857944,85.756302,45.033947,83.644302,43.689915); // B
  bezierVertex(81.340302,42.057949,78.748306,40.617950,75.868301,39.369915); // B
  bezierVertex(72.892311,38.121952,69.724312,37.065952,66.364304,36.201916); // B
  vertex(47.068306,31.017914); // B
  bezierVertex(46.588345,31.113964,46.204342,31.305958,45.916306,31.593914); // B
  bezierVertex(45.532345,31.785957,45.196342,32.025959,44.908306,32.313915); // B
  bezierVertex(44.620346,32.601959,44.332344,32.937958,44.044308,33.321915); // B
  bezierVertex(43.756348,33.609959,43.468349,33.993958,43.180309,34.473915); // B
  vertex(37.564308,28.713913); // B
  vertex(6.316310,21.369911); // B
  bezierVertex(6.508386,23.193966,6.940386,24.873962,7.612310,26.409912); // B
  bezierVertex(8.188385,27.849960,8.956384,29.145958,9.916310,30.297913); // B
  bezierVertex(11.164382,31.833958,12.844380,33.033955,14.956309,33.897911); // B
  bezierVertex(17.068375,34.665955,19.612373,35.049953,22.588308,35.049911); // B
  bezierVertex(23.548368,35.049953,24.508368,35.001953,25.468307,34.905910); // B
  bezierVertex(26.332365,34.809952,27.244364,34.713951,28.204308,34.617912); // B
  bezierVertex(29.164362,34.425953,30.076361,34.281956,30.940308,34.185913); // B
  bezierVertex(31.804359,33.993954,32.668358,33.801956,33.532307,33.609913); // B
  vertex(33.532307,33.609913); // B
  endShape();
  popMatrix();

}
