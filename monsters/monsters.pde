import hpglgraphics.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

float radius = 100;
float res = 80;
float xScl = 0.00009;
float yScl = 0.0001;
float radiusStep = 3;
int totalCircles = 200;
float rotateStep = -PI/totalCircles/2;
float angleStep = 1;
float hpglScale = 0.92; // wrong A4 scale (hpgl lib ?) so we compensate

boolean openPath = true;
boolean randomPath = true;
boolean randomAngleStep = false;
boolean randomRotateStep = true;

float xoff;
float yoff;

float startAngle;
float endAngle;

boolean isSaving = false;
HPGLGraphics hpgl;
String fileName;

void setup() {
  size(800, 567);
  noFill();

  hpgl = (HPGLGraphics) createGraphics(width, height, HPGLGraphics.HPGL);
  hpgl.setPaperSize("A4");

  // populate variables
  seed();
}

void draw() {
  background(255);
  stroke(0);
  xoff = 0;
  yoff = 0;

  DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd@HH_mm_ss");
  Date d = new Date();
  fileName = formatter.format(d);
  hpgl.setPath(fileName + ".hpgl");

  if (isSaving) {
    beginRecord(hpgl);
  }

  pushMatrix();
  scale(0.5 / hpglScale);
  translate(width / 2, height / 2);
  rotate(0);

  // draw A6 frame
  rect(-width/2, -height/2, width, height);

  for (int i = 0; i < totalCircles; i++) {
    drawCircle(radius + (i * radiusStep));
  }

  popMatrix();

  if (isSaving) {
    endRecord();

    save(fileName + ".jpg");
    isSaving = false;
    println("saved");
  }
  noLoop();
}

void drawCircle(float radius) {
  if (randomPath) {
    startAngle = random(-PI, -PI/2);
    endAngle = random(PI/2, PI);
  }

  beginShape();
  for (int i = 0; i < res; i++) {
    float angle = map(i, 0, res, startAngle, endAngle);
    float n = noise(sin(xoff), sin(angle) * angleStep, yoff);
    int x = floor(cos(angle) * radius);
    int y = floor(sin(angle) * radius);

    x *= n;
    y *= n;

    vertex(x, y);

    xoff += xScl;
  }
  yoff += yScl;
  endShape(openPath ? 0 : CLOSE);

  rotate(rotateStep);
}

void keyPressed() {
  if (key == 's') {
    isSaving = true;
    loop();
  }

  if (key == 'r') {
    seed();
    loop();
  }
}

void seed() {
  noiseSeed((long)random(0, 25500));

  if (openPath) {
    startAngle = random(-PI, -PI/2);
    endAngle = random(PI/2, PI);
  } else {
    startAngle = -PI;
    endAngle = PI;
  }

  if (randomAngleStep) {
    angleStep = random(0.5, 4);
  }

  if (randomRotateStep) {
    rotateStep = random(-PI/totalCircles, PI/totalCircles);
  }
}
