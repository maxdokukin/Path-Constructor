class AlertMessage{
  
  String text;
  PVector p0, dimensions, textPosition;
  color col;
  int lifetime = 0;
  boolean dead = false;
  long startTime = -1;
  
  AlertMessage(String t, int lt, color c){
    
    text = t;
    //this.p0 = p0;
    //this.pf = pf;
    lifetime = lt;
    col = c;
    startTime = millis();
  }
  
  AlertMessage(){}
  
  
  
  void show(){
    
    stroke(0);    
    fill(150);
    rect(p0.x, p0.y, dimensions.x, dimensions.y);
    fill(col);
    text(text, textPosition.x, textPosition.y);
  }
  
  void update(){
        
    if(millis() - startTime >= lifetime)
      dead = true;
  }
  
  void setP0(PVector v){
    
    p0 = v.copy();
  }
  
  
  void setDimensions(PVector v){
    
    dimensions = v.copy();
  }
  
  
  void setTextPosition(PVector v){
    
    textPosition = v.copy();
  }
  
  
  void printInfo(){
    
    println("Alert \'"+ text + "\'; isDead : " + dead + "   lifetime : " + lifetime);
  }
}
  
  
  
  
    
