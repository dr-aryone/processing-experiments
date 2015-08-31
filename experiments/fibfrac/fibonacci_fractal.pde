// see: https://hal.archives-ouvertes.fr/hal-00367972/document


// globals
int W=1000, H=1000, FR=100, STEP=1, fibindex=0, segindex=0, dir=0;
String fibword1 = "0", fibword2 = "01";
PVector position;

// generate the next fibonacci word segment
void nextseg() {
	String next = fibword1 + fibword2;
	fibword1 = fibword2;
	fibword2 = next;
	segindex = 0;
}

// setup the canvas
void setup() {
  size(W, H);
  frameRate(FR);
  smooth();
  int cx = 0;//width/2;
  int cy = height;//height/2;
	position = new PVector(cx, cy);
}

// main draw loop
void draw() {
	PVector currPos = new PVector(position.x, position.y);
	switch (dir) {
		case 0:
			position.y -= STEP; break;
		case 1:
			position.x += STEP; break;
		case 2:
			position.y += STEP; break;
		case 3:
			position.x -= STEP; break;
	}
	line(currPos.x,currPos.y, position.x,position.y);

	update();
}

void update() {
	char nextChar = fibword2[segindex];

	if (str(nextChar) == "0") {
		if (fibindex%2 == 0)
			dir = (dir-1)%4;
		else
			dir = (dir+1)%4;
	}
	
	segindex++;
	fibindex++;
	if (segindex >= fibword2.length) nextseg();

  /*
	console.log(
		"position: "+position.x+","+position.y+" | "+
		"fibindex: "+fibindex+" | " +
		"segindex: "+segindex+" | " +
		"dir: "+dir+" | "+
		"fibwords: "+fibword1+","+fibword2+" | "+
		"nextChar: "+nextChar
	);
	//*/
}

