ArrayList arr;
boolean flag=true;
int distance= 50;
void setup()
{
  size(800,800);
  smooth();
  arr = new ArrayList();
  for (int i=0;i<420;i++)
  {
    Particle P = new Particle();
    arr.add(P);
  }
}
void mousePressed()
{
}
void draw()
{
  background(1);
  for (int i=0;i<arr.size();i++)
  {
    Particle Pn1 = (Particle) arr.get(i);
    Pn1.display();
    Pn1.update();
    for (int j = i + 1; j < arr.size(); j++) {
      Particle Pn2 = (Particle) arr.get(j);
      Pn2.update();
      if (dist(Pn1.x, Pn1.y, Pn2.x, Pn2.y)< distance)
      {
        for (int k = j + 1; k < arr.size(); k++) {
          Particle Pn3 = (Particle) arr.get(k);
          if (dist(Pn3.x, Pn3.y, Pn2.x, Pn2.y)< distance) {
            if (flag) {
              stroke(255, 10);
              fill(Pn3.c, 95); // method to access the class property
            }
            else {
              noFill();
              strokeWeight(1);
              stroke(0, 0);
            }
            beginShape(LINES);
            stroke(53,248,159,10);
            vertex(Pn1.x, Pn1.y);
            vertex(Pn2.x, Pn2.y);
            vertex(Pn3.x, Pn3.y);
            endShape();
          }
 
          Pn3.update();
        }
      }
    }
  }
}
 
void keyPressed()
{
  flag=!flag;
}
class Particle {
  float x, y, r;
  color c;
  int i=1, j=1;
  Particle( )
  {
    x = random(0, width);
    y = random(0, height);
    r = random(PI,PI);
    c = color(#35F89F);
  }
 
  void display()
  {
    pushStyle();
    noStroke();
    fill(c);
    ellipse(x, y, r, r);
    popStyle();
  }
 
  void update()
  {
    x = x + j*0.01;
    y = y + i*0.01;
    if (y > height-r) i=-1;
    if (y < 0+r) i=1;
    if (x > width-r) j=-1;
    if (x < 0+r) j=1;
  }
}