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
    initWalker(center_, polarRadius_, randomAngle_, randomSpeed_, random(5, 20));
  }

  Walker(PVector center_, float polarRadius_, float randomAngle_, float randomSpeed_, float radius_) {
    initWalker(center_, polarRadius_, randomAngle_, randomSpeed_, radius_);
  }

  void initWalker(PVector center_, float polarRadius_, float randomAngle_, float randomSpeed_, float radius_) {
    neighborposition = null;
    neighborsList = new ArrayList<PVector>();
    center = center_.copy();
    position = defineNewWalkerPosition(polarRadius_, randomAngle_, randomSpeed_);
    radius = radius_;
    stuck = false;
  }

  void display() {
    display(color(255));
  }

  void display(color c) {
    fill(c);
    noStroke();
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

  void displayShadowRect(float shadowLength, float angle) {
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    fill(255, 0, 0);
    beginShape();
    fill(127);
    vertex(0, -radius);
    fill(127, 0);
    vertex(radius*shadowLength, -radius);
    vertex(radius*shadowLength, radius);
    fill(127);
    vertex(0, radius);
    endShape();
    popMatrix();
  }

  void displayShadowRectFromLight(float shadowLength, PVector light, float incShadow) {
    PVector target = PVector.sub(light, position);
    float angle = target.heading();
    float dist = PVector.dist(light, position);
    dist = norm(dist, 0, hypotenuse / 2);
    
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    beginShape();
    fill(255 * (1.0 - incShadow));
    vertex(0, -radius);
    fill(255 * (1.0 - incShadow), 0);
    vertex((radius + radius * 2 * (shadowLength * dist)) * -1, -radius);
    vertex((radius + radius * 2 * (shadowLength * dist)) * -1, radius);
    fill(255 * (1.0 - incShadow));
    vertex(0, radius);
    endShape();
    popMatrix();
  }
  
  
  void displayRealShadowRectFromLight(float shadowLength, PVector light, float incShadow) {
    
    float dist = PVector.dist(light, position);
    PVector target = PVector.sub(light, position);
    float angle = target.heading();
    dist = 1.0 + norm(dist, 0, hypotenuse / 2);
    
    PVector top = new PVector(0, radius).rotate(angle);
    PVector bottom = new PVector(0, -radius).rotate(angle);
    top.add(position);
    bottom.add(position);
    
    PVector targetNextTop = PVector.sub(light, top).normalize().mult(radius * shadowLength * dist);
    PVector targetNextBottom = PVector.sub(light, bottom).normalize().mult(radius * shadowLength * dist);
    PVector nextTop = top.copy().sub(targetNextTop);
    PVector nextBottom = bottom.copy().sub(targetNextBottom);
    
    beginShape();
    fill(255 * (1.0 - incShadow));
    vertex(top.x, top.y);
    fill(255 * (1.0 - incShadow), 0);
    vertex(nextTop.x, nextTop.y);
    vertex(nextBottom.x, nextBottom.y);
    fill(255 * (1.0 - incShadow));
    vertex(bottom.x, bottom.y);
    endShape();
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