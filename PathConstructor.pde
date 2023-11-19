class PathConstructor{
  
  boolean lineMode = false;
  boolean arcMode = false;
  boolean active = false;
  Path currentPath;
  boolean newSegmentAvailable = false;
  
  
  void update(){
    
    if(ow.isButtonPressed(0)){
      
      lineMode = true;
      arcMode = false;
      active = true;
    }
    else if(ow.isButtonPressed(1)){
      
      lineMode = false;
      arcMode = true;
      active = true;
    }
    else{
     
      active = false;
    }
  
    
    if(active){
      
      if(lineMode){
        
        if(currentPath != null){
          
          PathSegment curEnd = currentPath.end;
          PVector p0 = curEnd.pf;
          PVector pf = new PVector(mv.mappedMouseX(), mv.mappedMouseY());
          
          color col = color(255, 0, 0);
          int idd = curEnd.id + 1;
          
          PathSegment newSegment = new PathSegment(p0, pf, curEnd.col, idd);
          
          newSegment.show();
          
          if(approvePosition == 1){
            
            currentPath.add(newSegment);
            approvePosition = -1;
          }
        }
        
        
        if(newP0.x != -1){
          
          PVector pf = new PVector(mv.mappedMouseX(), mv.mappedMouseY());
          
          PathSegment newSegment = new PathSegment(newP0, pf, getRandomRgb(), 0);
          
          newSegment.show();
          
          if(approvePosition == 1){
            
            pm.getLastPath().add(newSegment);
            approvePosition = -1;
            newP0 = new PVector(-1, -1);
            
            currentPath = pm.getLastPath();
          }          
        }
        //println("line mode");
        
      }
      
      
      else if(arcMode){
        
        //println("arc mode");
        
        
      }

    }
  }
  
  
  void setCurPath(Path p){
    
    if(currentPath == null && active && newP0.x == -1){
      
      currentPath = p;
      currentPath.constructionInProgress = true;
      println("cur path set to p");      
    }
  }
  
  
  
  void keyPressedEvent(int kc){
    
    if(kc == 81){
      
      currentPath = null;
      newP0 = new PVector(-1, -1);
      approvePosition = -1;
    }
  }
  
  PVector newP0 = new PVector(-1, -1);
  int approvePosition = -1;  
  void mousePressedEvent(){
    
    if(currentPath != null || newP0.x != -1)
      approvePosition++;
    
    else if(currentPath == null && active && newP0.x == -1){
      newP0 = new PVector(mv.mappedMouseX(), mv.mappedMouseY());
      pm.pathes.add(new Path());
    }
}
  
  
  
}


color getRandomRgb() {

  return color(random(255), random(255), random(255));
}
