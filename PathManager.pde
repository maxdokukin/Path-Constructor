class PathManager{
  
  ArrayList <Path> pathes = new ArrayList<Path>();
  int pathConstructing = -1;
  int selectedPath = -1;
  
  PathConstructor pathConstruct = new PathConstructor();
  
  PathManager(){
    
    pathes.add(new Path());
    pathes.get(0).add(new PathSegment(new PVector(100, 100), new PVector(200, 200), color(0, 0, 255), 0));
    pathes.get(0).add(new PathSegment(new PVector(200, 200), new PVector(500, 800), color(0, 255, 0), 1));
    pathes.get(0).add(new PathSegment(new PVector(500, 800), new PVector(100, 100), color(100, 120, 200), 2));
    
    pathes.add(new Path());
    pathes.get(1).add(new PathSegment(new PVector(400, 100), new PVector(500, 100), color(0, 0, 255), 0));
  }
  
  
  void show(){
    
    for(Path p : pathes)
      p.show();
  }
  
  
  void update(){
    
    mouseOnPath();
    
    //if(pathConstructing != -1){
      
    //  //Path constructionPath = pathes.get(pathConstructing);
      
    //  pathes.get(pathConstructing).construction();
    //}
    
    pathConstruct.update();
    
    
  }
  
  void mousePressedEvent(){
    
    //for(Path p : pathes)
    //  if(p.constructionInProgress)
        //p.waitForMouseClicked();
        
    int path = mouseOnPath();
    
    if(path != -1)
      pathConstruct.setCurPath(pathes.get(path));
      
    pathConstruct.mousePressedEvent();
  }
  
  
  int mouseOnPath(){
    
    int selectedSegment = -1;
    
    //println("mouseOnPath");
    
    int selectedPath = -1;
    boolean found = false;
    
    for(Path p : pathes){
      
      selectedSegment = p.mouseOnSegment();
      
      selectedPath++;

      if(selectedSegment != -1){
         found = true;
         break;
      }
    }
    
          
    return found ? selectedPath : -1;
  }
  
  
  
  void keyPressedEvent(int kc){
    
    pathConstruct.keyPressedEvent(kc);
    println("pm");
  }
  
  
  void add(){
    
    
    
  }
  
  Path getLastPath(){
    
    println("pathes.size()");
    return pathes.get(pathes.size() - 1);
  }
  
  
}
