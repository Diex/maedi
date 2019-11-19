class Escamas {

  PVector pos = new PVector();
  PVector vel = new PVector();
  
  float angulo;
  //float direccion;
  //float c1;
  //float c2;
  //float varAux;  
  //float esc;
  //float contador;

  float zmax = 500;
  
  Escamas() {
    
    
    angulo = random(360);
    origin.set(width/2, height/2, -500);
    pos.set(0, 0, 500);
    vel.set(random(-1,1), random(-1,1), random(-10,10));
  }

  void update() {
    
    pos.add(vel);
    println(pos);
  }

PVector origin = new PVector();

  void limites() {
    if(screenX(pos.x, pos.y, pos.z) < 0 || screenX(pos.x, pos.y, pos.z) > width){
      pos.x = pos.x * -1;     
      //println("ouch...");
    };
    
    
    if(screenY(pos.x, pos.y, pos.z) < 0 || screenY(pos.x, pos.y, pos.z) > height){
      pos.y = pos.y * -1;     
      //println("ouch...");
    };
    
    if(pos.z < origin.z - zmax){
        pos.z = origin.z + zmax;
    }
      if(pos.z > origin.z + zmax){
      pos.z = origin.z - zmax;     
      //println("ouch...");
    };
    
    
    //if (x<-10) {
    //  x=width+10;
    //}
    //if (x>width+10) {
    //  x=-10;
    //}    
    /////limite en y   
    //if (y<-10) {
    //  y=height+10;
    //}
    //if (y>height+10) {
    //  y=-10;
    //}
  }

  void transparencia() {
    //c1+=varAux;

    //if (c1==1000 || c1==0) {
    //  varAux=varAux*-1;
    //}
    //c2=map(c1, 0, 500, 5, 10);
    
    //stroke(0, c2);
    //println(c2);
    // println(contador );
  }
  
  
  //void contador() {
  //  if (contador>=15)contador=0; 
  //  else contador++;
  //}

  void escala() {
    //esc=(c2/15);

    //scale(esc);
    //println(esc);
  }

  //void transformar() {
  //  //translate(x, y);
  //  rotate(angulo);
  //}

  
  void dibujar() {
    limites();
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
    
    
    
    
    move();
    pushMatrix();
    translate(-baricenter.x, -baricenter.y, -baricenter.z);
    lineFromPoints(a, b);
    lineFromPoints(b, c);
    lineFromPoints(c, a);
    
    lineFromPoints(h, a);
    lineFromPoints(h, b);
    lineFromPoints(h, c);
    popMatrix();
    
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
  
  void move(){
    translate(pos.x, pos.y, pos.z);
  }
}
