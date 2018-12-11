import hpglgraphics.*;
HPGLGraphics hpgl;

int cols = 100;
int rows = 180;

int xmargin = 50;
int ymargin = 50;

float startNoise = cols/2.3;
float endNoise = cols;
float noiseScl = 0.3;
float weight = 80;

void setup() {
  size(600, 800);

  hpgl = (HPGLGraphics) createGraphics(width, height, HPGLGraphics.HPGL);
  hpgl.setPaperSize("A3");
  hpgl.setPath("line_chaos_03.hpgl");

  background(255);
  stroke(0);
  noFill();
}

void draw() {
  beginRecord(hpgl);

  // fake draw sheet (for accurate dimension)
  hpgl.selectPen(0);
  stroke(0, 255, 0);
  rect(0, 0, width, height);
  
  translate(xmargin, ymargin);

  hpgl.selectPen(1);
  hpgl.setSpeed(1);
  stroke(0);
  
  float xoff = 0;
  float yoff = 0;

  for (int y = 0; y < rows; y++) {
    beginShape();
    xoff += noiseScl;
    float currStartNoise = startNoise + random(-20, 20);
    for (int x = 0; x < cols; x++) {
      yoff += noiseScl;
      float xpos = map(x, 0, cols, 0, width - xmargin*2);
      float ypos = map(y, 0, rows, 0, height - ymargin*2);
      float n =  noise(xoff, yoff) * weight - weight/2;
      n = n * sin(PI - (float)x/rows * PI/2);

      if (x == currStartNoise) {
        endShape();
      }
      
      if (x == currStartNoise + 1) {
        stroke(255, 120, 120);
        beginShape();
      }

      if (x > currStartNoise && x < endNoise) {
        //xpos += n - map(x, 0, cols, -weight/2, weight);
        ypos += n;
      } else {
        ypos += random(-0.4, 0.4);
      }

      vertex(xpos, ypos);
    }
    endShape();
  }


  noLoop();

  endRecord();
}
