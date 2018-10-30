class Particle {
  PVector dir;
  PVector vel;
  PVector pos;
  float speed = .4;

  public Particle(float x, float y) {
    dir = new PVector(0, 0);
    vel = new PVector(0, 0);
    pos = new PVector(x, y);
  }

  PVector move() {
    float angle = noise(this.pos.x/noiseScale, this.pos.y/noiseScale)*TWO_PI*300;
    dir.x = cos(angle);
    dir.y = sin(angle);
    vel = dir.copy();
    vel.mult(speed);
    pos.add(vel);

    return pos;
  }

  boolean isOnEdge() {
    return pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0;  
  }

  void display() {
    vertex(pos.x, pos.y);
  }
}
