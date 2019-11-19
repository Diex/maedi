void setup() {
  size(640, 480);
}


void draw() {

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {

      color miColor;
      if (random(1000) < 20) {
        miColor = color(255, 0, 0);
      } else {
        miColor = color(0, 0, 255);
      }

      set(x, y, miColor);
    }
  }

  noLoop();
}