class PathSegment {

  boolean linePath = false, highlight = false;
  PVector p0, pf, pc, delta;
  PVector arrowP1, arrowP2;
  color col;
  float realLength = 0;
  int scanIterations;
  float scanTincrement;
  int id = -1;

  //ArrayList <PathSegment> nextSegment = new ArrayList<PathSegment>();

  PathSegment nextSegment = null, previousSegment = null;

  PathSegment(PVector p0, PVector pf, color c, int idd) {

    id = idd;
    linePath = true;
    this.p0 = p0;
    this.pf = pf;
    delta = new PVector(pf.x - p0.x, pf.y - p0.y);
    col = c;

    realLength = delta.mag();
    scanIterations = int(realLength / 10) + 1;
    scanTincrement = 1 / (float) scanIterations;
    
    PVector arrowBasisPoint = getProg_p(realLength - 20);
    arrowP1 = new PVector(arrowBasisPoint.x + delta.copy().rotate(HALF_PI).normalize().x * 5, arrowBasisPoint.y + delta.copy().rotate(HALF_PI).normalize().y * 5);
    arrowP2 = new PVector(arrowBasisPoint.x+ delta.copy().rotate(-1 * HALF_PI).normalize().x * 5, arrowBasisPoint.y + delta.copy().rotate(-1 * HALF_PI).normalize().y * 5);
    
    //println("realLength" + realLength + "   scanIterations " + scanIterations + "   heading " + delta.heading() * 360/TWO_PI);
  }

  PathSegment(PVector p0, PVector pf, PVector pc, color c, int idd) {

    id = idd;
    linePath = false;
    this.p0 = p0;
    this.pf = pf;
    this.pc = pc;
    //work on delta
    //delta = new PVector(pf.x - p0.x, pf.y - p0.y);
    col = c;
  }


  void show() {

    if (highlight)
      stroke(255, 0, 0);
    else
      stroke(col);

    noFill();

    if (linePath) {

      line(p0.x, p0.y, pf.x, pf.y);
      //println("line" + p0.x + "   " + p0.y + "   " +  pf.x + "   " +  pf.y);      
      
      fill(col);
      circle(p0.x, p0.y, 5);
      triangle(pf.x, pf.y, arrowP1.x, arrowP1.y, arrowP2.x, arrowP2.y);
    } else {
      
      noFill();
      arc(p0.x, p0.y, pf.x, pf.y, pc.x, pc.y);
    }
  }

  PathSegment getNext() {

    return nextSegment;//.size() == 0 ? null : nextSegment.get(0);
  }

  void setPrev(PathSegment p) {

    previousSegment = p;
  }

  void highlight() {

    highlight = true;
  }

  PVector getPos_t(float t) {

    if (linePath) {

      return new PVector(p0.x + delta.x * t, p0.y + delta.y * t);
    } else
      return null;
  }
  
  PVector getProg_p(float p){
    
    return getPos_t(p / realLength);
  }
}
