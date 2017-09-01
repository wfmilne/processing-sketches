void setup() {
  size(640, 640);
  stroke(0, 125, 255, 125);
  fill(255);
}

void draw() {
  background(20);
  translate(width/2, height/2);
  for (int x = -5; x <= 5; x++) {
    for (int y = -5; y <= 5; y++) {
      pushMatrix();
      translate(x*20, y*20);
      rotate(sin(radians((y*x)*5+frameCount)));
      strokeWeight(3+sin(radians((y*x)*5+frameCount))*3);
      ellipse(-20, -20, 10, 10);
      popMatrix();
    }
  }
}
