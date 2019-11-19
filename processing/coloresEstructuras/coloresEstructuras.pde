
void setup() {
  
  size(78, 497);
  PImage colors = loadImage("colors");
  image(colors,0,0);
  int delta = height/60; // cada 10 minutos
  println("int colors[][3] = {");
  
  for (int y = 0; y < height; y += delta) {
    
    println("{" 
            + (int)green(get(0, y)) 
            + "," 
            + (int)red(get(0, y))
            + "," 
            + (int)blue(get(0, y)) 
            + "},");
  }
  
  println("};");
}
