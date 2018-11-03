import hpglgraphics.*;
int spacing = 8;
int[][] lines;
int cols;
int rows;

void setup() {
  size(631, 890);
  HPGLGraphics hpgl = (HPGLGraphics) createGraphics(width, height, HPGLGraphics.HPGL);
  hpgl.setPaperSize("A4");
  hpgl.setPath("output.hpgl");

  background(255);
  stroke(0);
  strokeWeight(0.7);
  noFill();
  smooth();

  cols = width / spacing;
  rows = height / spacing;
  lines = createLinesArray();

  beginRecord(hpgl);
  hpgl.setSpeed(1);
  hpgl.selectPen(1);
  drawLines(0);
  hpgl.selectPen(2);
  stroke(255, 0, 0);
  drawLines(1);
  endRecord();
}

int[][] createLinesArray() {
  int[][] lines = new int[cols][rows];
  for (int i = 0; i < lines.length; i++) {
    int x = i * spacing;
    for (int j = 0; j < lines[i].length; j++) {
      int y = j * spacing;
      float p = map(y, height * 0.15, height * 0.85, 0, 1);
      if (random(1) < p) {
        lines[i][j] = 0;
      } else {
        lines[i][j] = 1;
      }
    }
  }
  return lines;
}

void drawLines(int dir) {
  if (dir == 0) {
    // start at the bottom of the sketch

    // begin walking for each col, from bottom
    for (int i = 0; i < cols - 1; i++) {
      walkInArray(i, rows - 1, dir, false);
    }


    // begin walking for each row, from right
    for (int j = rows-1; j > 0; j--) {
      walkInArray(cols - 1, j, dir, false);
    }
  } else {
    for(int i = cols - 1; i >= 0; i--) {
      walkInArray(i, 0, dir, false);
    }
    for(int j = 1; j < rows - 1; j++) {
      walkInArray(cols-1, j, dir, false);
    }
  }
}

void walkInArray(int col, int row, int dir, boolean hasShapeBegun) {
  int nextCol = col - 1;
  int nextRow = row + 1;
  int lastCol = -1;
  boolean condition = col >= 0 && row < rows;
  int x = col * spacing + spacing;
  int y = row * spacing;

  if (dir == 0) {
    nextCol = col - 1;
    nextRow = row - 1;
    lastCol = -1;
    condition = col >= 0 && row >= 0;
    x = col * spacing + spacing;
    y = row * spacing + spacing;
  }
  if (condition) {
    if (lines[col][row] == dir) {
      if (!hasShapeBegun) {
        beginShape();
        vertex(x, y);
      }
      walkInArray(nextCol, nextRow, dir, true);
    } else {
      if (hasShapeBegun) {
        vertex(x, y);
        endShape();
      }

      walkInArray(nextCol, nextRow, dir, false);
    }
  }

  if (col == lastCol && hasShapeBegun) {
    vertex(x, y);
    endShape();
  }
}
