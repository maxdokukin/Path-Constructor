class MappedView {

  float globalScale = 1;
  float minScale, maxScale;
  float mouseDragMPL;

  boolean showGrid = true;
  boolean disableMovement = false;

  PVector dimensions;
  PVector translation = new PVector(0, 0);
  PVector maxMappedSize;
  PVector biasStep, biasStepMapped;

  PVector prevMXY = new PVector(0, 0);

  MappedView(int w, int h) {

    dimensions = new PVector(w, h);
    maxMappedSize = new PVector(w * -1, h * -1);
    biasStep = new PVector(w / 20, w / 20);
    biasStepMapped = biasStep.copy();

    minScale = 1 / (float) (w / width);
    maxScale = height / 100;

    mouseDragMPL = w / 20;

    updateMappedSize();
  }


  void show() {

    if (showGrid)
      drawGrid();
  }


  void updateScale(float u) {
    
    if(disableMovement)
      return;
      
    globalScale += u / (float) pow(map(globalScale, 0.05, 10, 30, 1), 2);

    globalScale = int(globalScale * 1000) / (float) 1000;

    if (globalScale < minScale)
      globalScale = minScale;

    if (globalScale > maxScale)
      globalScale = maxScale;

    updateMappedSize();
    updateTranslation(-1, -1);
    updateTranslation(1.003, 1.003);

    //println("global scale : " + globalScale);
    ow.updatePosition();
    amm.updatePosition();
    //println("scale : " + globalScale);
  }

  void updateTranslation(float dx, float dy) {
    
    if(disableMovement)
          return;
          
    //inWindowView();

    if (dx > 0) {

      if (translation.x - biasStepMapped.x * dx > maxMappedSize.x)
        translation.x -= biasStepMapped.x * dx;
      else
      translation.x = maxMappedSize.x;
      //println("bias x : " + translation.x);
    }

    if (dx < 0) {

      if (translation.x - biasStepMapped.x * dx <= 0)
        translation.x -= biasStepMapped.x * dx;
      else
        translation.x = 0;
    }

    if (dy > 0) {

      if (translation.y - biasStepMapped.y * dy > maxMappedSize.y)
        translation.y -= biasStepMapped.y * dy;
      else
      translation.y = maxMappedSize.y;

      //println("bias y : " + translation.y);
    }

    if (dy < 0) {
      if (translation.y - biasStepMapped.y * dy <= 0)
        translation.y -= biasStepMapped.y * dy;
      else
        translation.y = 0;
    }

    amm.updatePosition();
    ow.updatePosition();

  }


  void updateMappedSize() {
    
    if(disableMovement)
      return;
      
    maxMappedSize.x = -1 * (dimensions.x * globalScale - width);
    maxMappedSize.y = -1 * (dimensions.y * globalScale - height);

    //println("maxMappedSize X : " + maxMappedSize.x + "   Y : " + maxMappedSize.y);
  }

  void updateBiasStep() {

    biasStepMapped = biasStep.div(globalScale);
  }

  //does not work
  boolean inWindowView(PVector vec) {

    //println(translation.x * -1 + "   " + translation.y * -1 + "   " + (translation.x * -1 + (width * globalScale)) + "   " + (translation.y * -1 + (height * globalScale)));

    return (vec.x > translation.x * -1) && (vec.y > translation.y * -1) && (vec.x < translation.x * -1 + (width * globalScale)) && (vec.y < translation.y * -1 + (height * globalScale));
  }
  
  //does not work
  boolean lineInWindowView(PVector p0, PVector pf) {
    
    //at least one point in frame handles
    if (inWindowView(p0) || inWindowView(pf))
      return true;
    
    //print((p0.y + " " + translation.y * -1)); print("   "); println((pf.y > translation.y * -1 + (height * globalScale)));
    //y out of frame lines handles
    if ((p0.y <= translation.y * -1 && pf.y >= translation.y * -1 + (height * globalScale)) && (((translation.x * -1) < p0.x && p0.x < (translation.x * -1 + (width * globalScale))) || ((translation.x * -1) < pf.x && pf.x < (translation.x * -1 + (width * globalScale)))))
      return true;

    if ((p0.y >= translation.y * -1 && pf.y <= translation.y * -1 + (height * globalScale)) && (((translation.x * -1) < p0.x && p0.x < (translation.x * -1 + (width * globalScale))) || ((translation.x * -1) < pf.x && pf.x < (translation.x * -1 + (width * globalScale)))))
      return true;

    //if((p0.x < translation.x * -1 && pf.x > translation.x * -1 + (width * globalScale)) &&
    //  (((translation.y * -1) < p0.y && p0.y < (translation.y * -1 + (height * globalScale))) ||
    //   ((translation.y * -1) < pf.y && pf.y < (translation.y * -1 + (height * globalScale)))))

    //println(translation.x * -1 + "   " + translation.y * -1 + "   " + (translation.x * -1 + (width * globalScale)) + "   " + (translation.y * -1 + (height * globalScale)));
    return false;
    //return (vec.x > translation.x * -1) && (vec.y > translation.y * -1) && (vec.x < translation.x * -1 + (width * globalScale)) && (vec.y < translation.y * -1 + (height * globalScale));
  }

  float mappedMouseX() {

    float mappedMouseX = int(round((mouseX + translation.x * -1) / globalScale / 10)) * 10;
    //println("mappedMouseX : " + mappedMouseX);
    return mappedMouseX;
  }

  float mappedMouseY() {

    float mappedMouseY = int(round((mouseY + translation.y * -1) / globalScale / 10) * 10);
    //println("mappedMouseY : " + mappedMouseY);
    return mappedMouseY;
  }


  float getMappedX(float originalX) {

    return (translation.x * -1 + originalX) / globalScale;
  }

  float getMappedY(float originalY) {

    return (translation.y * -1 + originalY) / globalScale;
  }

  PVector getMappedPosition(PVector pos) {

    return new PVector((translation.x * -1 + pos.x) / globalScale, (translation.y * -1 + pos.y) / globalScale);
  }

  void mouseDraggedEvent() {

    float dx = (mouseX - prevMXY.x) * -1;
    float dy = (mouseY - prevMXY.y) * -1;

    prevMXY.x = mouseX;
    prevMXY.y = mouseY;

    updateTranslation(dx / mouseDragMPL, dy / mouseDragMPL);
  }

  void mouseMovedEvent() {

    prevMXY.x = mouseX;
    prevMXY.y = mouseY;
  }

  void mousePressedEvent() {

    mv.mappedMouseX();
    mv.mappedMouseY();
  }


  void mouseWheelEvent(float delta) {

    mv.updateScale(delta * -1);
  }


  void keyPressedEvent(int k) {

    if (k == 38)
      updateTranslation(0, -1);

    if (k == 40)
      updateTranslation(0, 1);

    if (k == 39)
      updateTranslation(1, 0);

    if (k == 37)
      updateTranslation(-1, 0);

    if (k == 71)
      showGrid = !showGrid;

    if (k == 67)
      ow.expandKeyPressed();//

    println(k);
  }


  void drawGrid() {

    stroke(255, 0, 255);
    fill(255, 0, 255);

    textSize(16);

    for (int i = 0; i <= mv.dimensions.x; i += 100) {

      line(i, 0, i, mv.dimensions.y);

      for (int j = 0; j <= mv.dimensions.y; j += 100)
        text(i + " ", i + 3, j + 15);
    }

    stroke(0, 255, 255);
    fill(0, 255, 255);
    for (int i = 0; i <= mv.dimensions.y; i += 100) {

      line(0, i, mv.dimensions.x, i);

      for (int j = 0; j <= mv.dimensions.x; j += 100)
        text(i + " ", j + 3, i + 30);
    }
  }
}
