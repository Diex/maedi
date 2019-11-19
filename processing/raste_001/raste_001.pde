int raster_rows = 60;
int raster_cols = 64;


void setup() {
  size(200, 480);
}


void draw() {
  drawGrid();
}


void drawGrid() {
  float w = width / raster_cols;
  float h = height / raster_rows;
  
  
  for (int y = 0; y < raster_rows; y++) {
    line(0, y*h, width, y*h);
     
  }

  for (int x = 0; x < raster_cols; x++) {
    line(x*w, 0, x*w, height);
  }
}
