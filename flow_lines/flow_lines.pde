import hpglgraphics.*;

HPGLGraphics hpgl;

int nums = 200;
int iterations = 800;
int noiseScale = 600;
boolean isSaving = false;

void setup() {
  size(800, 600);

  hpgl = (HPGLGraphics) createGraphics(width, height, HPGLGraphics.HPGL);
  hpgl.setPaperSize("A4");
  hpgl.setPath("flow_lines.hpgl");

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
    PVector startPos = new PVector(random(0, width), random(0, height));
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
