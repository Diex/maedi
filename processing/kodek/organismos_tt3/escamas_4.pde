class escamas_4 {

  float x;
  float y;
  float velocidad;
  float velocidad2;
  float angulo;
  float direccion;
  float c1;
  float c2;
  float varAux;  
  float esc;
  float contador;

  escamas_4() {
    fill(0,0);
    x=width/4;
    y=height/4;
    contador=0;
    velocidad=0.5;
    velocidad2=0.3;
    angulo=random(360);
    direccion=-1;
    c1=10;
    c2=30;
    varAux=2;  
    esc=0.5;
  }

  void update() {
    contador();
    angulo += random(-0.1, 0.1);
    x+=cos(angulo)*velocidad2;
    y+=sin(angulo)*velocidad2;

    limite();
  }

  void limite() {
    if (x<-10) {
      x=width+10;
    }
    if (x>width+10) {
      x=-10;
    }    
    ///limite en y   
    if (y<-10) {
      y=height+10;
    }
    if (y>height+10) {
      y=-10;
    }
  }

  void transparencia() {
    c1+=varAux;

if (c1==1000 || c1==0) {
      varAux=varAux*-1;
    }
c2=map(c1,0,500,5,10);
    stroke(0, c2);
 //println(c2);
   // println(contador );
  }
  void contador() {
    if (contador>=15)contador=0; else contador++;
  }

  void escala() {
    esc=(c2/10);

    scale(esc);
    //println(esc);
  }

  void transformar() {
    translate(x, y);
    rotate(angulo);
  }

  void dibujar() {
  pushMatrix();
    transparencia();
    transformar();
  escala();
    line(-10, 10, 20, 20);
    line(20, 20, 20, -10);
    line(20, -20, -10, 10);
    // println(ancho );
  popMatrix();
  }
}
