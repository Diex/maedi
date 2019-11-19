class Escamas {

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

  Escamas() {
    fill(0, 0);
    x=width/2;
    y=height/4;
    contador=0;
    velocidad=0.2;
    velocidad2=0.3;
    angulo=random(360);
    direccion=-1;
    c1=10;
    c2=30;
    varAux=2;  
    esc=0.5;
  }

  void angle(float alpha){
    angulo = alpha;
  }
  void update() {
    contador();
    
    //angulo += random(-0.1, 0.1);
    x+= cos(radians(angulo)) *velocidad2;
    y+= sin(radians(angulo)) *velocidad2;

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
    //c1+=varAux;

    //if (c1==1000 || c1==0) {
    //  varAux=varAux*-1;
    //}
    //c2=map(c1, 0, 500, 5, 10);
    
    stroke(0, c2);
    //println(c2);
    // println(contador );
  }
  
  
  void contador() {
    if (contador>=15)contador=0; 
    else contador++;
  }

  void escala() {
    //esc=(c2/15);

    scale(esc);
    //println(esc);
  }

  void transformar() {
    translate(x, y);
    rotate(angulo);
  }

  
  void dibujar() {
  
    pushMatrix();
    
    //transparencia();
    //transformar();
    //escala();
    
    //translate(mouseX, mouseY);
    float largo = 100;
    
    noFill();
    //stroke(0, 10);
    stroke(0);
    
     
    // base de la piramide
    PVector a = new PVector(0,        0,      0); 
    PVector b = new PVector(1,        0,      0);
    PVector c = new PVector(0.5,  0.866,      0);
    PVector h = new PVector(0.5,  0.866 / 3.0,      0.866);
    
    a.mult(largo);
    b.mult(largo);
    c.mult(largo);
    h.mult(largo);
    
    PVector baricenter = new PVector( 0.5, 0.866 / 3.0, 0.866/3.0);
    baricenter.mult(largo);
    
    
    translate(-baricenter.x, -baricenter.y, -baricenter.z);
    
    lineFromPoints(a, b);
    lineFromPoints(b, c);
    lineFromPoints(c, a);
    
    lineFromPoints(h, a);
    lineFromPoints(h, b);
    lineFromPoints(h, c);
    
    
    //line(0 * largo  , 0 * largo      , 0 * largo, 1 * largo    , 0 * largo      , 0 * largo);
    //line(1 * largo  , 0 * largo      , 0 * largo, 0.5 * largo  , 0.866 * largo  , 0 * largo);
    //line(0.5 * largo, 0.866 * largo  , 0 * largo, 0 * largo    , 0 * largo      , 0 * largo);
    //// aristas
    //line(0 * largo  , 0 * largo      , 0 * largo, 0.5 * largo  , 0.217 * largo  , 0.717 * largo);
    //line(1 * largo  , 0 * largo      , 0 * largo, 0.5 * largo  , 0.217 * largo  , 0.717 * largo);
    //line(0.5 * largo, 0.866 * largo  , 0 * largo, 0.5 * largo  , 0.217 * largo  , 0.717 * largo);
    
    
    popMatrix();
  }
  
  void lineFromPoints(PVector aPoint, PVector anotherPoint){    
    line(aPoint.x, aPoint.y, aPoint.z, anotherPoint.x, anotherPoint.y, anotherPoint.z);  
  }
}
