/**
 * Moon Phases
 * 
 * Creates a series of moons that go through different phases.
 * Part of this code is based on Jerome Herr's (P5art's) sketch
 * "the moon", located here: http://www.openprocessing.org/sketch/181224.
*/

color moonColor = #ffe699;
color bgColor = #1C1B2F;
float radius = 60;
int frames = 250;
int columns = 4;
int rows = 5;
int cell = 108;
float delay = 0;

void setup() {
  size(540, 648);
  noStroke(); 
}

//Draws the rows and columns of moons.
//Adds a delay for each moon.
void draw() {
  background(bgColor);
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < columns; i++) {
      float x = i*cell;
      float y = j*cell;
      pushMatrix();
      translate(x, y);
      drawMoon(delay);
      delay = delay+0.025;
      popMatrix();
    } 
  }
   delay = 0;
   
   //if (frameCount%5 == 0 && frameCount <= frames) saveFrame("image-###.tiff");
}

//Draws a moon. 
//This function is a modifiend version of "the moon" by Jerome Herr.
void drawMoon(float delay) {
  float t = ((frameCount%frames)/(float)frames)+delay;
  translate(cell, cell);
  //Moon growing to full moon
  if (t < 0.5) { 
    float tt = map(t, 0, 0.5, 0, 1); 
    if (tt < 0.5) { 
      float r = map(tt, 0, 0.5, radius, 0);
      fill(moonColor);
      arc(0, 0, radius, radius, PI/2, PI*1.5); //left moon
      fill(bgColor);
      arc(0, 0, r, radius, PI/2, PI*1.5); //left background shrinking
    } else {
      float r = map(tt, 0.5, 1, 0, radius);
      fill(moonColor);
      arc(0, 0, r, radius, -PI/2, PI/2); //right moon growing
      arc(0, 0, radius, radius, PI/2, PI*1.5); //left moon
    }
    //Moon shrinking to new moon
  } else {
    float tt = map(t, 0.5, 1, 0, 1);
    if (tt < 0.5) {
      float r = map(tt, 0, 0.5, radius, 0); 
      fill(bgColor);
      arc(0, 0, radius, radius, PI/2, PI*1.5); //left background
      fill(moonColor);
      arc(0, 0, radius, radius, -PI/2, PI/2); //right moon
      arc(0, 0, r, radius, PI/2, PI*1.5); //left moon shrinking
    } else {
      float r = map(tt, 0.5, 1, 0, radius); 
      fill(moonColor);
      arc(0, 0, radius, radius, -PI/2, PI/2); //right moon
      fill(bgColor);
      arc(0, 0, r, radius, -PI/2, PI/2); //right background growing
    }
  }
}