MappedView mv;
OperationWindow ow;
PathManager pm;;
AlertMessageManager amm;
IOmanager io;

Button b;
//Path path = new Path();

void setup() {

  size(1000, 500);
  pixelDensity(2);
  
  mv = new MappedView(2000, 2000);
  ow = new OperationWindow(new PVector(width - 1, 0), new PVector(-50, 50), new PVector(-200, 300), color(150, 150, 150));
  pm = new PathManager();
  amm = new AlertMessageManager(new PVector(width * 0.6, height * 0.9), new PVector(width * 0.4, height * 0.1));
  io = new IOmanager();

  ow.assignMappedView(mv);
  
  ow.initializeButtons();
  
}


void draw() {

  translate(mv.translation.x, mv.translation.y);
  scale(mv.globalScale);
  
  background(90);
  
  pm.update();
  amm.update();
  
  mv.show();
  pm.show();
  ow.show();
  amm.show();
}




void keyPressed() {

  mv.keyPressedEvent(keyCode);
  pm.keyPressedEvent(keyCode);
  println(keyCode);
}

void mousePressed(){
  
 mv.mousePressedEvent();
 ow.mousePressedEvent();
 pm.mousePressedEvent();
}

void mouseWheel(MouseEvent event) {
  
  mv.mouseWheelEvent(event.getCount());  
}

void mouseMoved(){
  
  mv.mouseMovedEvent();
}

void mouseDragged() {
    
  mv.mouseDraggedEvent();  
}

void fileSelected(File selection) {
  
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    amm.addAlert("Loading cancelled" , 3000, color(0, 0, 255));
    
  } else {
    
    io.loadFile(selection.getAbsolutePath());
    amm.addAlert("Loading " + selection.getName(), 3000, color(0, 0, 255));
    
    //println("User selected " + selection.getAbsolutePath());
  }
}
