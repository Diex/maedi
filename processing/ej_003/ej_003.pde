size(600, 600);
background(79,12,240);

rectMode(CENTER);
stroke(91,240,12);
fill(240,138,12);

for(int y = 0; y <= 600; y = y+1){
  float posx = random(0,600);
  float posy = random(0,600);;
  ellipse(posx, posy, 10,10);
}