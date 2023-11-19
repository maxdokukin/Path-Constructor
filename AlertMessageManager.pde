class AlertMessageManager{
  
  PVector p0, pf, dimensions, mappedDimensions, mappedPosition;
  
  ArrayList <AlertMessage> alerts = new ArrayList <AlertMessage>();
  
  float textSize = 0;
  PVector textBias, mappedTextBias;
  
  AlertMessageManager(PVector p0, PVector dimensions){
    
    this.p0 = p0;
    pf = p0.copy().add(dimensions);
    println(p0 + "   " + pf);
    this.dimensions = dimensions;
    
    textSize = dimensions.y * 0.5;
    textBias = new PVector(dimensions.x * 0.03, dimensions.y * 0.7);
    
    mappedPosition = p0;
    mappedDimensions = dimensions;
    mappedTextBias = textBias;
  }
  
  void show(){
    
    textSize(textSize);

    for(AlertMessage a : alerts)
      a.show(); 
  }
  
  
  void update(){
    
    for(int i = 0; i < alerts.size(); i++){
      
      alerts.get(i).update();
      
      if(alerts.get(i).dead){
        
        alerts.get(i).printInfo();
        alerts.remove(i);
        updateAlertsPositions();
      }
    }
  }
  
  
  void updateAlertsPositions(){
    
    for(int i = 0; i < alerts.size(); i++){
      
      PVector curP0 = new PVector(mappedPosition.x, mappedPosition.y - mappedDimensions.y * i);
            
      alerts.get(i).setP0(curP0);
      alerts.get(i).setDimensions(mappedDimensions);
      alerts.get(i).setTextPosition(new PVector(curP0.x + mappedTextBias.x, curP0.y + mappedTextBias.y));
    }
  }
  
  
  void updatePosition(){
    
    mappedPosition = mv.getMappedPosition(p0);
    mappedTextBias = textBias.copy().div(mv.globalScale);
    mappedDimensions = dimensions.copy().div(mv.globalScale);

    textSize = dimensions.y * 0.5 / mv.globalScale;

    updateAlertsPositions();    
  }
  
  void addAlert(String text, int lifetime, color c){
    
    AlertMessage am = new AlertMessage(text, lifetime, c);
    am.printInfo();
    
    alerts.add(am);
    updateAlertsPositions();
  }  
}
