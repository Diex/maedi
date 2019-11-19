size(800, 800);
background(237, 219, 19);

rectMode(CORNER);
fill(171, 19, 237);

int posx;   // declaracion de la variable

/*
  esto es todo un comentario.
  
  for(contador ; condición ; incremento) {

   }
*/

int cuenta = 0;
for(posx = 0 ; posx < width; posx = posx + 60){
  println("la variable posx vale: " + posx);
  println("la cuenta esta en: " + cuenta++);
  rect(posx, height/2, 25, 25);
}