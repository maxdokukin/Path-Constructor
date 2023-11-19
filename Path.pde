class Path{
  
  PathSegment start = null, end = null;
  boolean constructionInProgress = false;
  
  void add(PathSegment p){
    
    if(start == null){
      
      start = p;
      end = p;
      p.nextSegment = null;
      p.previousSegment = null;      
    }
    
    else{
      
//      PathSegment temp = end;
      
      end.nextSegment = p;
      p.previousSegment = end;
      end = p;
    }    
  }
  
  
  
  void show(){
    
    for(PathSegment currentSegment = start; currentSegment != null; currentSegment = currentSegment.getNext()){
      
      //if(mv.lineInWindowView(currentSegment.p0, currentSegment.pf))
        currentSegment.show();
    }
    
    downlightAllSegments();

  }
  
  
  void newLineShadow(){
    
    
  }
  
  
  PVector onLinePos(PVector p0, PVector pf, float t){
    
    return new PVector((pf.x - p0.x) * t, (pf.y - p0.y) * t);
  }
  
  
  int mouseOnSegment(){    
    
    PathSegment currentSegment = start;
    for(; currentSegment != null; currentSegment = currentSegment.getNext())  
      //if(mv.inWindowView(currentSegment.p0) || mv.inWindowView(currentSegment.pf))
      for(float t = 0; t <= 1; t += currentSegment.scanTincrement){
        
        PVector pos_t = currentSegment.getPos_t(t);
        
        if(dist(pos_t.x, pos_t.y, mv.mappedMouseX(), mv.mappedMouseY()) < 10){
          
          downlightAllSegments();
          currentSegment.highlight();
          
          if(currentSegment.getNext() != null)
            currentSegment.getNext().highlight();

          //println("currentSegment " + currentSegment.id);
          
          return currentSegment.id;
        }
      }
    return -1;
  }
  
  
  void downlightAllSegments(){
    
    for(PathSegment currentSegment = start; currentSegment != null; currentSegment = currentSegment.getNext()){
      
      currentSegment.highlight = false;
    }
    
  }
}
