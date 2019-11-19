size(800, 800);
colorMode(HSB);

background(207, 202, 209);

rectMode(CENTER);
fill(105, 222, 252);


int cant = 40;
noStroke();


for(int i = 0; i < cant ; i++){
  int separacion = width / (cant - 1);
  int posx = i * separacion;
  
  if(i%5 == 0){
    rect(posx, 200, 10 , 100);
  }else{
    rect(posx, 200, 10 , 10);
  }
  
}


//i * width/(cant - 1)