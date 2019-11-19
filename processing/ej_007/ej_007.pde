void setup(){
  size(640, 480);  
}


void draw(){

  float ancho = 200;
  
  beginShape(LINES);
  vertex(0.5* ancho, 20);
  vertex(width/2, height/2);
  
  
  vertex(60, 200);
  vertex(400, 200);
  
  endShape();

}