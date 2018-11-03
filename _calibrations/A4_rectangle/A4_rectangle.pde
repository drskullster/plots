import hpglgraphics.*;

HPGLGraphics hpgl;

void setup() {
  size(1000, 683);

  hpgl = (HPGLGraphics) createGraphics(width, height, HPGLGraphics.HPGL);
  hpgl.setPaperSize("A4");
  hpgl.setPath("A4_rectangle.hpgl");

  background(255);
}

void draw() {
  noFill();
  smooth();
  background(255);

  beginRecord(hpgl);
  hpgl.setSpeed(2);
  hpgl.selectPen(1);
  
  rect(0, 0, width, height);
  
  endRecord();
  noLoop();
}
