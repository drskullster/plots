import hpglgraphics.*;

HPGLGraphics hpgl;

int nums = 100; // times number of colors
int iterations = 3000;
int noiseScale = 100;
boolean isSaving = false;

void setup() {
  size(800, 600);

  hpgl = (HPGLGraphics) createGraphics(width, height, HPGLGraphics.HPGL);
  hpgl.setPaperSize("A4");
  hpgl.setPath("output.hpgl");

  background(255);
}

void draw() {
  noFill();
  smooth();
  background(255);

  beginRecord(hpgl);
  hpgl.setSpeed(5);

  hpgl.selectPen(1);
  stroke(80, 26, 216);
  drawLines();

  hpgl.selectPen(2);
  stroke(216, 26, 165);
  drawLines();

  hpgl.selectPen(3);
  stroke(255, 0, 0);
  drawLines();

  endRecord();
  noLoop();
}

void drawLines() {
  Particle[] particles = new Particle[nums];

  for (int i = 0; i < nums; i++) {
    PVector startPos;
    if(random(0, 1) > 0.5) {
      startPos = new PVector(0, random(0, height));
    } else {
      startPos = new PVector(random(0, width), 0);
    }

    particles[i] = new Particle(startPos.x, startPos.y);
    beginShape();
    for (int j = 0; j < iterations; j++) {
      PVector pos = particles[i].move();
      if (particles[i].isOnEdge()) {
        break;
      } else {
        if (j % 20 == 0) {
          vertex(pos.x, pos.y);
        }
      }
    }
    endShape();
  }
}
