class Button{
  
  PVector position, mappedPosition, dimensions, mappedDimensions, textPosition, textPositionMapped;
  float controlSize, controlSizeMapped;
  String txt;
  color baseColor, onColor, pressedColor;
  boolean buttonPressed, justPressed;
  
  MappedView mappedView;

  Button(PVector pos, PVector dim, String t, color c){
    
    position = pos;
    mappedPosition = position.copy();
    
    dimensions = dim;
    mappedDimensions = dimensions.copy();
    
    controlSize = dim.y * 0.75;
    controlSizeMapped = controlSize;
    
    txt = t;
    baseColor = c;
    onColor = lerpColor(baseColor, color(255, 255, 255), 0.5);
    pressedColor = lerpColor(baseColor, color(0, 0, 0), 0.5);
    
    textPosition = new PVector(position.x + dimensions.x * 0.1, position.y + dimensions.y * 0.8);
    textPositionMapped = textPosition.copy();
  }
  
  void show(){
    
    if(buttonPressed){
      
      stroke(pressedColor);
      fill(pressedColor);
    }
    else if(mouseOnButton()){
      
      stroke(onColor);
      fill(onColor);
    }
    else{
      
      stroke(baseColor);
      noFill();
    }
    
    rect(mappedPosition.x, mappedPosition.y, mappedDimensions.x, mappedDimensions.y);
    
    textSize(controlSizeMapped);
    fill(baseColor);
    text(txt, textPositionMapped.x, textPositionMapped.y);
  }
    
    
  void updatePosition(){
    
    mappedPosition = mappedView.getMappedPosition(position);
    mappedDimensions = dimensions.copy().div(mappedView.globalScale);

    textPositionMapped = new PVector(mappedPosition.x + mappedDimensions.x * 0.1, mappedPosition.y + mappedDimensions.y * 0.8);
    
    controlSizeMapped = controlSize / mappedView.globalScale;
  }
  
  void assignMappedView(MappedView mapVw){
    
    mappedView = mapVw;
  }
  
  
  boolean mouseOnButton(){
    
    return((mouseX >= position.x && mouseX <= position.x + dimensions.x) && (mouseY >= position.y && mouseY <= position.y + dimensions.y));
  }
  
  
  void resetJustPressed(){
    
    justPressed = false;
  }
  
  void mousePressedEvent(){
    
    if(mouseOnButton()){
      
      buttonPressed = !buttonPressed;
      
      justPressed = buttonPressed;
    }
  }
    
    
 
  
  
  
  
  
  
}
