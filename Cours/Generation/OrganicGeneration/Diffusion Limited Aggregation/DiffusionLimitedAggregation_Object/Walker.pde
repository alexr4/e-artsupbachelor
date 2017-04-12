class Walker
{
  PVector center;
  PVector position;
  float radius;
  boolean stuck;
  PVector neighborposition;
  ArrayList<PVector> neighborsList;

  //polar coordinate
  float polarRadius;
  float polarAngle;
  float polarRadiusSpeed;
  float radiusFromNeighbor;
  float angleFromNeighbor;
  PVector positionFromNeighbors;

  Walker(PVector center_, float polarRadius_, float randomAngle_, float randomSpeed_) {
    neighborposition = null;
    neighborsList = new ArrayList<PVector>();
    center = center_.copy();
    position = defineNewWalkerPosition(polarRadius_, randomAngle_, randomSpeed_);
    radius = random(5, 20);
    stuck = false;
  }

  void display() {
    stroke(255);
    noFill();
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }

  void displayLinesBetweenLatestNeighbor() {
    if (neighborposition != null) {
      stroke(255, 0, 0);
      line(position.x, position.y, neighborposition.x, neighborposition.y);
    }
  }

  void displayLinesBetweenNeighbor() {
    if (neighborsList != null) {
      stroke(255, 0, 255);
      for (int i=0; i<neighborsList.size(); i++) {
        PVector n = neighborsList.get(i);
        line(position.x, position.y, n.x, n.y);
      }
    }
  }

  void displayRect() {
    if (positionFromNeighbors != null) {
      pushMatrix();
      translate(positionFromNeighbors.x, positionFromNeighbors.y);
      rotate(angleFromNeighbor);
      noFill();
      stroke(255, 255, 0);
      rect(0, 0, radius * 2, radius * 2);
      rectMode(CENTER);
      popMatrix();
    }
  }

  void updateWalkerPosition() {
    if (!stuck) {
      polarRadius -= polarRadiusSpeed;
      position.x = center.x + cos(polarAngle) * polarRadius;
      position.y = center.y + sin(polarAngle) * polarRadius;
    }
  }

  void computeAngleFromFirstNeighbor(Walker w) {
    PVector neiPos = w.neighborsList.get(0);
    w.radiusFromNeighbor = PVector.dist(neiPos, w.position);
    w.angleFromNeighbor = atan2(w.position.y - neiPos.y, w.position.x - neiPos.x);
    w.positionFromNeighbors = new PVector();
    w.positionFromNeighbors.x = neiPos.x + cos(w.angleFromNeighbor) * w.radiusFromNeighbor;
    w.positionFromNeighbors.y = neiPos.y + sin(w.angleFromNeighbor) * w.radiusFromNeighbor;
  }

  PVector defineNewWalkerPosition(float polarRadius_, float randomAngle_, float randomSpeed_) {
    polarRadius = polarRadius_;
    polarAngle = randomAngle_;
    polarRadiusSpeed = randomSpeed_;
    float x = center.x + cos(polarAngle) * polarRadius;
    float y = center.y + sin(polarAngle) * polarRadius;

    return new PVector(x, y);
  }

  boolean isStuck(Walker neighbor) {
    float dist = PVector.dist(neighbor.position, position);
    if (dist <= neighbor.radius + radius) {
      neighborposition = PVector.sub(neighbor.position, position).setMag(neighbor.radius + radius).add(position);
      neighborsList.add(neighborposition);
      walker.neighborsList.add(position);
      neighbor.position = neighborposition.copy();
      computeAngleFromFirstNeighbor(walker);
      walker.stuck = true;

      return true;
    } else {
      return false;
    }
  }
}