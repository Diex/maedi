size(800, 800);
colorMode(HSB);
background(207, 202, 250);

rectMode(CENTER);


noStroke();

int cant = 1000;
fill(105, 222, 252, 20);

for (int i = 0; i < cant; i++) { 
  int posx = (int) random(width/4, width*3/4);
  float posy = random(0, height);
  float dim = random(20, 100);
  ellipse(posx, posy, dim, dim);
}


fill(#C91073, 255);

int cantRects = 40;

for(int i = 0; i < cantRects; i++){
  float dim = sin(radians(360/cantRects * i) * 2.50) * 40;
  rect(width/cantRects * i, height/2, 10, dim); 
}



//i * width/(cant - 1)