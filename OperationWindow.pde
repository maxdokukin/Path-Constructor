class OperationWindow{
  
  PVector position, mappedPosition, dimensions, mappedDimensions, expandedDimensions, expandControlPosition;
  color winColor;
  boolean expanded = false;
  float controlSize, controlSizeMapped;
    
  MappedView mappedView;
    
  Button [] buttons = new Button[6];

  OperationWindow(PVector pos, PVector dim, PVector exDim, color c){
    
    position = pos;
    dimensions = dim;
    expandedDimensions = exDim;
    winColor = c;
    
    mappedPosition = position.copy();
    mappedDimensions = dimensions.copy();
    expandControlPosition = position.copy().add(dim.copy().div(2));
    
    controlSize = dim.y / 2;
    controlSizeMapped = controlSize;       
  }
  
  
  void show(){
    
    //if(saveLoad.active){
      
    //  saveLoad.show();
    //  mv.disableMovement = saveLoad.active;
    //}
      
    stroke(winColor);
    fill(winColor);
    rect(mappedPosition.x, mappedPosition.y, mappedDimensions.x, mappedDimensions.y);
    

    if(expanded){
      
      updateButtons();
      
      for(Button b : buttons)
        b.show();
                
      fill(224, 95, 88);
    }
    else{
      
      fill(120, 203, 79);
    }
    

    stroke(winColor);
    circle(expandControlPosition.x, expandControlPosition.y, controlSizeMapped);

  }
  
  
  void assignMappedView(MappedView mapVw){
    
    mappedView = mapVw;
  }
  
  
  void expandKeyPressed(){
    
    expanded = !expanded;
    updatePosition();

  }
  
  
  void mousePressedEvent(){
    
    if((mouseX <= position.x && mouseX >= position.x + dimensions.x) && (mouseY >= position.y && mouseY <= position.y + dimensions.y)){
      
      expanded = !expanded;
      updatePosition();
      //println("expansion");
    }
    
    if(expanded)
      for(Button b : buttons)
        b.mousePressedEvent();
    
    //save button
    if(buttons[4].buttonPressed){
      
      buttons[4].buttonPressed = false;
      expandKeyPressed();
      String savedFileName = io.saveToFile();
      
      amm.addAlert("Saved to " + savedFileName, 3000, color(0, 0, 255));
    }
    
    //load
    if(buttons[5].buttonPressed){
      
      amm.addAlert("Select file", 3000, color(0, 0, 255));
      buttons[5].buttonPressed = false;
      expandKeyPressed();
      
      selectInput("Select a file to process:", "fileSelected");

      //String loadedFileName = io.loadFile();
    }
  }
  
  
  void updatePosition(){
    
    mappedPosition = mappedView.getMappedPosition(position);
    
    if(expanded)
      mappedDimensions = expandedDimensions.copy().div(mappedView.globalScale);
    else
      mappedDimensions = dimensions.copy().div(mappedView.globalScale);
     
      
    expandControlPosition =  mappedView.getMappedPosition(position).add(dimensions.copy().div(mappedView.globalScale).div(2));
    
    controlSizeMapped = controlSize / mappedView.globalScale;
    
    updateButtonsPosition();
  }
  
  boolean isButtonPressed(int id){
    
    return buttons[id].buttonPressed;
  }
  
  
  void updateButtonsPosition(){
    
    for(Button b : buttons)
      b.updatePosition();
  }
  
  void updateButtons(){
    
    int ind = -1;
    for(int i = 0; i < 4; i++)
      if(buttons[i].justPressed)
        ind = i;
        
    if(ind != -1){
      
      for(Button b : buttons)
        b.buttonPressed = false;
        
      buttons[ind].buttonPressed = true;
      buttons[ind].justPressed = false;
    }
  }
  
  void initializeButtons(){
    
    //add math position calculction
    buttons[0] = new Button(new PVector(position.x + expandedDimensions.x + 10, position.y + 50), new PVector(180, 40), "Line mode", color(225, 193, 88));
    buttons[1] = new Button(new PVector(position.x + expandedDimensions.x + 10, position.y + 100), new PVector(180, 40), "Arc mode", color(225, 193, 88));
    buttons[2] = new Button(new PVector(position.x + expandedDimensions.x + 10, position.y + 150), new PVector(180, 40), "Link mode", color(67, 128, 41));
    buttons[3] = new Button(new PVector(position.x + expandedDimensions.x + 10, position.y + 200), new PVector(180, 40), "Setup mode", color(67, 128, 41));
    buttons[4] = new Button(new PVector(position.x + expandedDimensions.x + 10, position.y + 250), new PVector(85, 40), "Save", color(255, 120, 255));
    buttons[5] = new Button(new PVector(position.x + expandedDimensions.x + 105, position.y + 250), new PVector(85, 40), "Load", color(255, 120, 255));

    for(Button b : buttons)
      b.assignMappedView(mappedView);
  }
}
