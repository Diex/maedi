size(800, 800);
colorMode(HSB);
background(207, 202, 209);

rectMode(CENTER);
fill(105, 222, 252);

noStroke();

int cant = 40;
int incx = width / (cant - 1);
int incy = height / (cant - 1);

for (int posy = 0; posy < height; posy = posy + incy) { 
  for (int posx = 0; posx < width; posx = posx+incx) {      
    
    if(random(1000) < 10) continue;
    
    if(random(1000) < 500) {
      fill(105, 222, 252);
      rect(posx, posy, 10, 10);
    else{
      fill(#DCFC4C);
      ellipse(posx, posy, 10, 10); 
    }
    
  }
}



//i * width/(cant - 1)