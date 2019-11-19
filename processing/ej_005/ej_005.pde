
void setup(){
  size(800, 800);
  frameRate(30);
}

void draw(){
//  background( random(255), 0, random(255));  
  int cant = 100;  
  fill(#639D5C);
  noStroke();
  for(int i = 0; i < cant; i++){
    //ellipse(random(width), random(height), 5, 5);
    //rotate( radians(random(360)));
    //translate(x, y);
    text("MAEDI", random(width), random(height));
  }  
  
  //  saveFrame("maedi1####.jpg");
}