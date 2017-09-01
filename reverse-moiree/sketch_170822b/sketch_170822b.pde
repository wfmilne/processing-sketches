float tam;
int quantas;
float px[] = new float[100];
float py[] = new float[100];
float pxa[] = new float[100];
float pya[] = new float[100];
float pv[] = new float[100];

void setup() {
  size (900, 500);
  quantas=100;
  for (int i=1; i<quantas; i++) {
    px[i]=random(width);
    py[i]= random(height);
    pxa[i]=random(width);
    pya[i]= random(height);
     pv[i]= int(random(250, 500));
  }
}

void draw() {
  background(0);

  noStroke();
  while (tam>5) {
    fill(0);
    for (int i=1; i<quantas; i++) {
      ellipse(px[i], py[i], tam, tam);
    }
    tam-=6;
    fill(255);
    for (int i=1; i<quantas; i++) {
      ellipse(px[i], py[i], tam, tam);
    }
    tam-=6;
  }
  for (int i=1; i<quantas; i++) {
    if (dist(px[i], py[i], pxa[i], pya[i])<10) {
      pxa[i]=random(width);
      pya[i]= random(height);
      pv[i]= int(random(250, 500));
    } else {
      px[i]+=((pxa[i]-px[i])/pv[i]);
      py[i]+=((pya[i]-py[i])/pv[i]);
    }
  }
  tam=120;
}