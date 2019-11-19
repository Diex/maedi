class Escamas {

  PVector pos = new PVector();
  PVector vel = new PVector();

  float angulo;
  Quaternion orientation = new Quaternion();
  PVector origin = new PVector();

  float zmax = 600;
  PVector pAccel = new PVector();
  float pAvg = 0.0;

  float largo = 10;

  float maxLargo = 500;
  float maxAcc = 500;

  float alpha = 1;
  float minAlpha = 3;
  float maxAlpha = 15;


  float maxSpeed = 2;

  String name;
  
  Escamas(String name) {
    this.name = name;
    angulo = random(360);
    origin.set(width/2, height/2, -3000);
    pos.set(random(-width/width), random(-height/height), -1000);
    vel.set(random(-2, 2), random(-2, 2), random(-5, 5));
  }


  void transparencia() {
  }


  void setAcceleration(float x, float y, float z) {

    float dx = pAccel.x - x;
    float dy = pAccel.y - y;
    float dz = pAccel.z - z;


    pAccel.set(x, y, z);

    float avgAcc = (dx + dy + dz) / 3;
    float dAvg = pAvg - abs(avgAcc);

    pAvg = ease(avgAcc, pAvg, dAvg >= 0 ? 0.995 : 0.2);


    //println(dx, dy, dz, "avg: ", map(abs(pAvg), 0, maxAcc, 0.0, 1.0));
  }



  void dibujar() {

    limites();

    largo = constrain( map(abs(pAvg), 0, maxAcc, 0, maxLargo), maxLargo/10, maxLargo);
    alpha = constrain( map(abs(pAvg), maxAcc, 0, 0, maxAlpha), minAlpha, maxAlpha);

    pushMatrix();
    pushStyle();

    noFill();
    stroke(0, alpha);


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

    popStyle();
    popMatrix();
  }

  void applyRot() {
    float[] axis = orientation.toAxisAngle();
    rotate(-axis[0], -axis[1], -axis[3], axis[2]);
  }

  void lineFromPoints(PVector aPoint, PVector anotherPoint) {    
    line(aPoint.x, aPoint.y, aPoint.z, anotherPoint.x, anotherPoint.y, anotherPoint.z);
  }

  void move() {
    translate(pos.x, pos.y, pos.z);
  }

  float ease(float current, float prev, float factor) {
    return current * (1 - factor) + prev * factor;
  }


  void update() {    
    setVelocity();    
    pos.add(vel);
  }


  void setVelocity() {
    float[] axis = orientation.toAxisAngle();
    PVector r =  new PVector();
    r.x = 2 * ((-axis[1] * axis[2]) + (-axis[0] * -axis[3]));
    r.y = 2 * ((-axis[3] * axis[2]) - (-axis[0] * -axis[1]));
    r.z = 1 - 2 * (-axis[1] * -axis[1] + (-axis[3]*-axis[3]));
    r.normalize().mult(maxSpeed);
    vel.set(r);
  }

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

  public void imu(float quant_w, float quant_x, float quant_y, float quant_z) {
    orientation.set(quant_w, quant_x, quant_y, quant_z);
  }

  public void realacc(float quant_x, float quant_y, float quant_z) {
    
    switch(name) {
      case "k4":
      // K4 default: -8871.0 -578.0 3826.0
        setAcceleration(quant_x +8871, quant_y+578, quant_z-3826);
      break;
    }
    
  }

  //public void ypr(float quant_x, float quant_y, float quant_z) {
  //  ypr.set(degrees(quant_x), degrees(quant_y), degrees(quant_z));    
  //}
}
