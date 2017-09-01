FlowerSystem fs;
int time;
float dt;
float t;
float w;
PImage backgroundImage;
color c1, c2, c3, c4, c5, c6;

void setup()
{
  size(800, 800);
  frameRate(30);
  strokeWeight(2);
  time = 300;
  
  
  c1 = color(255);
  c2 = color(#9012FE);
  c3 = color(#AB55F6);
  c4 = color(#2D0352);
  //c5 = color(#847691);
  //c6 = color(#2D0352);
  
  
  backgroundImage = createImage(5, 5, RGB);
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      float d = dist(i, j, 2, 2);
      backgroundImage.pixels[i+j*5] = lerpColor(c2, c3, map(d, 0, 5, 0, 1));
    }
  }
  
  backgroundImage.pixels[12] = c1;
  backgroundImage.resize(width, height);
  backgroundImage.filter(BLUR, 24);
  
  fs = new FlowerSystem(width/2, height/2, 3.33);
}

void draw()
{
  background(backgroundImage);
  image(backgroundImage, 0, 0);
  //println(frameRate);
  
  
  drawLine(166.5);
  
  drawCircle(time, 166.5, width/2, height/2);
  fs.addFlower(time);
  fs.run();
  
  time++;
}

void drawCircle(float time, float radius, float cx, float cy)
{
  float s = wave(0.5 * time, 0, 0, radius);
  float a = wave(0.5 * time, 0, 0, 60);
  float c = wave(0.5 * time, 0, 0, 1);
  
  pushMatrix();
  
  //Filled Circles
  translate(cx, cy);
  
  noStroke();
  fill(c4, a);
  ellipse(0, 0, s, s);
  
  rotate(-PI/6);
  
  for(int i=1; i <= 6; i++)
  {
    s = wave(6*time, 60*i, 0, radius);
    a = wave(12*time, 60*i, 0, 120);
    c = wave(3*time, 60*i, 0, 1);
    
    translate(radius, 0);
    
    fill(c4, a);
    ellipse(0, 0, s, s);
    
    translate(-radius, 0);
    rotate(PI/3);
  }
  
  rotate(-PI/3);
  
  // Empty Circle
  s = wave(12*time, 60, 0, radius);
  noFill();
  stroke(255, 150);
  
  for(int i=1; i <= 6; i++)
  {
    translate(radius, 0);
    
    ellipse(0, 0, radius, radius);
    ellipse(0, 0, s, s);
    
    translate(-radius, 0);
    rotate(PI/3);
  }
  
  popMatrix();
}

void drawLine(float size)
{
  stroke(255, 120);
  pushMatrix();
  translate(width/2, height/2);
  
  rotate(-PI/6);
  for(int i=0; i < 6; i++)
  {
    line(0, 0, 1000, 0);
    rotate(PI/3);
  }
  rotate(-PI/6);
  translate(0, -size);
  rotate(PI/6);
  for(int i=0; i < 6; i++)
  {
    line(0, 0, size, 0);
    translate(size, 0);
    rotate(PI/3);
  }
  rotate(radians(t));
  popMatrix();
}



// CLASS FLOWER SYSTEM

class FlowerSystem
{
  ArrayList<Flower> flowers;
  float posX, posY, rate;
  int timer, time_prev, time_step;
  
  FlowerSystem(float x, float y, float r)
  {
    posX = x;
    posY = y;
    time_step = floor(r * 30);
    time_prev = 0;
    timer = 0;
    flowers = new ArrayList<Flower>();
  }
  
  void addFlower(int time)
  {
    timer += time - time_prev;
    
    if( timer > time_step )
    {
      flowers.add(new Flower(posX, posY));
      timer = 0;
    }
    time_prev = time;
  }
  
  void run()
  {
    for (int i=0; i < flowers.size(); ++i)
    {
      Flower f = flowers.get(i);
      f.run();
      if (f.isDead()) flowers.remove(i);
    }
  }
}


// CLASS FLOWER OF LIFE

class Flower
{
  float posX, posY, time, lifespan;
  
  
  Flower(float x, float y)
  {
    posX = x;
    posY = y;
    time = 1;
    lifespan = 550.0;
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    time += 0.075;
    lifespan -= 1.0;
  }
  
  void display()
  {
    noFill();
    //strokeWeight(2);
    stroke(255, map(lifespan, 0, 550, 0, 240.0));
    
    float tS = time * time;
    
    pushMatrix();
    
    translate(posX, posY);
    ellipse(0, 0, tS, tS);
    
    rotate(-PI/6);
    
    for(int i=1; i <= 6; i++)
    {
      translate(tS/2, 0);
      ellipse(0, 0, tS, tS);
      translate(-tS/2, 0);
      rotate(PI/3);
    }
    popMatrix();
  }
  
  boolean isDead() {
    if (lifespan < 0.0)
    {
      return true;
    } else {
      return false;
    }
  }
}


float wave(float time, float phase, float min, float max)
{
  return map (sin ( radians( time + phase ) ), -1.0, 1.0, min, max);
}