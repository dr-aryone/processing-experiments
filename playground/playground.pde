ArrayList nodeMap;

final int ROWS = 10, DELTA_X = 50, DELTA_Y = 50, JITTER = 5;

void setup() {
  size(600,600);

  nodeMap = new ArrayList();
  for (int i=0; i<ROWS; i++) {
    ArrayList row = new ArrayList();
    float x = DELTA_X + random(JITTER*2) - JITTER;
    while (x < width-DELTA_X) {
      float y = DELTA_Y*(i+1) + (random(JITTER*2) - JITTER);
      row.add(new Node(x, y));

      // update x to find the next position
      x += DELTA_X + (random(JITTER*2) - JITTER);
    }
    nodeMap.add(row);
  }
  
  
  /*
  for (int i=0; i<nodeMap.size() - 1; i++) {
    for (int j=0; j<nodeMap.get(i).size()-1; j++) {
      Node currNode = nodeMap.get(i).get(j);
      int numOutflows = 1;//+int(random(0));
      for (int n=0; n<numOutflows; n++) {
        Node connection;
        bool skip = false;
        do {
          int conX = j + 1;//int(random(min(3, nodeMap.get(i).size() - j))) + 1,
              conY = i + int(random(4)) - 2;
          try {
            connection = nodeMap.get(conY).get(conX);
          } catch(e) {
            //continue;
            skip = true;
            break;
          }
        } while (connection != currNode && !currNode.outflow.contains(connection));
        if (skip) continue;
        currNode.addOutflow(connection);
        connection.addInflow(currNode);
      }
    }
  }*/

  window.nodeMap = (nodeMap);
}

void draw() {
  background(51, 51, 51);

  for (int i=0; i<nodeMap.size(); i++) {
    for (int j=0; j<nodeMap.get(i).size(); j++) {
      (Node)((ArrayList)nodeMap.get(i)).get(j).draw();
    }
  }
}

class Node {
  float x, y;
  ArrayList outflow, inflow;
  
  Node (float x, float y) {
    this.x = x;
    this.y = y;
    this.outflow = new ArrayList();
    this.inflow = new ArrayList();
  }

  void addOutflow(Node n) {
    this.outflow.add(n);
  }
  void addInflow(Node n) {
    this.inflow.add(n);
  }

  void draw() {
    fill(207, 207, 141);
    noStroke();
    float diam = 5 + 3*(inflow.size()+outflow.size());
    ellipse(this.x, this.y, diam, diam);

    //noFill();
    stroke(207,207,141); //,128);
    strokeWeight(3);
    for (int i=0; i<this.outflow.size(); i++) {
      Node connection = this.outflow.get(i);
      line(this.x, this.y, connection.x, connection.y);
      //console.log("drawing a line from "+this.x.toString()+","+this.y.toString()+" to "+connection.x.toString()+","+connection.y.toString());

    }
  }
}
