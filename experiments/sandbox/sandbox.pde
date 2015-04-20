void setup() {
  PVector q = new PVector(100, 100);
  console.log('q.mag():', q.mag());

  console.log("q.dist(new PVector(200,200)):", q.dist(new PVector(200,200)))
  console.log("q.dist(new PVector(0,0)):", q.dist(new PVector(0,0)))
}

