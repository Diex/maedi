
escamas objeto1[];
escamas_2 objeto2[];
escamas_3 objeto3[];
escamas_4 objeto4[];

int cantidad=1;


void setup() {
  size(600, 600);
  //randomSeed(100);
  background(255);
  stroke(0, 15);

  objeto1 = new escamas [cantidad];
  
  objeto2 = new escamas_2 [cantidad];
  
  objeto3 = new escamas_3 [cantidad];
   
  objeto4 = new escamas_4 [cantidad];

  for ( int i=0; i<cantidad; i++ ) {
     objeto1[i] = new escamas();
     objeto2[i] = new escamas_2();
     objeto3[i] = new escamas_3();
     objeto4[i] = new escamas_4();
  }
}

void draw() {

  for ( int i=0; i<cantidad; i++ ) {  
    pushMatrix();
        objeto1[i].dibujar();
        objeto2[i].dibujar();
        objeto3[i].dibujar();
        objeto4[i].dibujar();
    popMatrix();
        objeto1[i].update();
        objeto2[i].update();
        objeto3[i].update();
        objeto4[i].update();
  }
}
