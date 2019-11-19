class Escamas {

  PVector pos = new PVector();
  PVector vel = new PVector();

  float angulo;
  Quaternion orientation = new Quaternion();
  
  float zmax = 600;

  Escamas() {


    angulo = random(360);
    origin.set(width/2, height/2, -3000);
    pos.set(0, 0, -1000);
    //vel.set(random(-1, 1), random(-1, 1), random(-10, 10));
    
  }

  void update() {    
    pos.add(vel);
    
  }

  PVector origin = new PVector();

  void limites() {
    if (screenX(pos.x, pos.y, pos.z) < 0 || screenX(pos.x, pos.y, pos.z) > width) {
      pos.x = pos.x * -1;
    };

    if (screenY(pos.x, pos.y, pos.z) < 0 || screenY(pos.x, pos.y, pos.z) > height) {
      pos.y = pos.y * -1;
    };

    if (pos.z < origin.z - zmax) {
      pos.z = origin.z + zmax;
    }
    if (pos.z > zmax) {
      pos.z = origin.z - zmax;
    };
  }

  void transparencia() {

  }

  PVector pAccel = new PVector();
  float pAvg = 0.0;
  
  float maxLargo = 1000;
  
  void setAcceleration(float x, float y, float z){
    
    float dx = pAccel.x - x;
    float dy = pAccel.y - y;
    float dz = pAccel.z - z;
    
    
    pAccel.set(x, y, z);
    
   
    
   float avgAcc = (dx + dy + dz) / 3;
   
   float dAvg = pAvg - avgAcc;
   
   float maxAcc = 500;
   
   pAvg = ease(avgAcc, pAvg, dAvg >= 0 ? 0.99 : 0.00001);
   
   println(dx, dy, dz, "avg: ", map(abs(pAvg), 0, maxAcc, 0.0, 1.0));
    
    
    this.scale(constrain( map(abs(pAvg), 0, maxAcc, 0, maxLargo), maxLargo/10, maxLargo)); 
    
    //println((norm.x + norm.y + norm.z) / 3, largo);
    
    
  }
  
  
  float ease(float current, float prev, float factor){
    return current * (1 - factor) + prev * factor;
  }
  
  void scale(float value){
    this.largo = value;    
  }

  float largo = 10;
  void dibujar() {
    limites();
    
    
    
    
    pushMatrix();

    

    noFill();
    stroke(0);


    // base de la piramide
    PVector a = new PVector(0, 0, 0); 
    PVector b = new PVector(1, 0, 0);
    PVector c = new PVector(0.5, 0.866, 0);
    PVector h = new PVector(0.5, 0.866 / 3.0, 0.866);

    a.mult(largo);
    b.mult(largo);
    c.mult(largo);
    h.mult(largo);

    PVector baricenter = new PVector( 0.5, 0.866 / 3.0, 0.866/3.0);
    baricenter.mult(largo);




    move();
    applyRot();
    translate(-baricenter.x, -baricenter.y, -baricenter.z);
    
    
    
    lineFromPoints(a, b);
    lineFromPoints(b, c);
    lineFromPoints(c, a);

    lineFromPoints(h, a);
    lineFromPoints(h, b);
    lineFromPoints(h, c);

    popMatrix();
  }

  void applyRot(){
    float[] axis = orientation.toAxisAngle();
    rotate(-axis[0], -axis[1], -axis[3], axis[2]);
  }
  
  
  void lineFromPoints(PVector aPoint, PVector anotherPoint) {    
    line(aPoint.x, aPoint.y, aPoint.z, anotherPoint.x, anotherPoint.y, anotherPoint.z);
  }

  void move() {
    translate(pos.x, pos.y, pos.z);
  }
}
