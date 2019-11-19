Particle particles []; //<>//

void setup()
{
  background(250);
  size(800, 800);
  particles = new Particle[100];
  for (int i = 0; i < particles.length; i++){
    particles[i] = new Particle(width/2, height/2);
  }
}

void draw()
{
  
  for (int i = 0; i < particles.length; i++){
    particles[i].walk();
  }

}



class Particle{
  float x;
  float y;
  float px;
  float py;
  float speed = random(0.1, 5);
  float col = random(100);
  Particle(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void walk(){
    pushStyle();
    stroke(0, col);
    px = x; 
    py = y;
    x += random(-speed,speed);
    y += random(-speed,speed);
    line(x,y, px, py);
    popStyle();
  }

}