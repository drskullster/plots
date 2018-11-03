import hpglgraphics.*;

HPGLGraphics hpgl;

int numsBlack = 150;
int numsColor = 25;
int iterations = 2500;
int noiseScale = 200;
boolean isSaving = false;
int drawingWidth = 600;
int drawingHeight = 400;

void setup() {
  size(1000, 683);

  hpgl = (HPGLGraphics) createGraphics(width, height, HPGLGraphics.HPGL);
  hpgl.setPaperSize("A4");
  hpgl.setPath("output.hpgl");

  background(255);
}

void draw() {
  noFill();
  smooth();
  background(255);

  // draw surface to place drawing correctly
  hpgl.selectPen(3);
  rect(0, 0, width, height);

  beginRecord(hpgl);

  pushMatrix();
  translate(width / 2 - drawingWidth / 2, height / 2 - drawingHeight / 2);
  hpgl.setSpeed(3);

  hpgl.selectPen(1);
  stroke(0, 0, 0);
  drawLines(numsBlack);

  stroke(0, 0, 255);
  hpgl.selectPen(2);
  //strokeWeight(3);
  drawLines(numsColor);
/*
  stroke(255, 0, 255);
  hpgl.selectPen(3);
  //strokeWeight(3);
  drawLines(numsColor);

  stroke(255, 255, 0);
  hpgl.selectPen(4);
  //strokeWeight(3);
  drawLines(numsColor);
*/

  /*
  hpgl.selectPen(1);
   stroke(0,255,255);
   drawLines();

   hpgl.selectPen(2);
   stroke(255,0,255);
   drawLines();

   hpgl.selectPen(3);
   stroke(255,255,0);
   drawLines();

   hpgl.selectPen(4);
   stroke(0,0,0);
   drawLines();
   */
  popMatrix();
  endRecord();
  noLoop();
}

void drawLines(int nums) {
  Particle[] particles = new Particle[nums];

  for (int i = 0; i < nums; i++) {
    PVector startPos;
    if (random(0, 1) > 0.5) {
      startPos = new PVector(0, random(0, drawingHeight));
    } else {
      startPos = new PVector(random(0, drawingWidth), 0);
    }

    particles[i] = new Particle(startPos.x, startPos.y);
    beginShape();
    for (int j = 0; j < iterations; j++) {
      PVector pos = particles[i].move();
      if (particles[i].isOnEdge()) {
        vertex(pos.x, pos.y);
        break;
      } else {
        if (j % 50 == 0) {
          vertex(pos.x, pos.y);
        }
      }
    }
    endShape();
  }
}
