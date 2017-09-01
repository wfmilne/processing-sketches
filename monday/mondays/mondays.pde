PImage img;
String name = "monday"; //file name 
String type = "jpg"; //file type
int count = int(random(666));

color c;
int val;
int threshold;
final static int LEFT = 0;
final static int TOP = 1;

int mode = TOP; // glitch mode: LEFT, TOP.
float amt = 48; // threshold amount.

void setup() {

  img = loadImage(name + "." + type);
  size(865, 461  );
  println("eff.design");

  img.loadPixels();
  for (int i = 0; i < img.width-1; i++) {
    for (int j = 0; j < img.height-1; j++) {
      val = img.pixels[i+(j*img.width)];
      threshold = img.pixels[i+(j+1)*img.width];
      if (brightness(val) > brightness(threshold) + amt) { 
        switch(mode) {
        case LEFT:
          c = val;
          img.pixels[(i+1)+(j*img.width)] = c;
          break;
        case TOP:
          c = val;
          img.pixels[i+((j+1)*img.width)] = c;
          break;
        }
      }
    }
  }
  img.updatePixels();
  image(img, 0, 0); 
  save(name + "_" + count + "." + type);
  println("done");
  exit();
}