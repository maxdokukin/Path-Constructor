class IOmanager{
  
  
  
  
  
  
  
  void loadFile(String filename){
    
    
    //return "ldl.txt";
  }
  
  
  
  String saveToFile(){
    
    String [] data = getData();
    String filename = "saves/PathMap" + "-" + timestamp() + ".txt";
    
    saveStrings(filename, data);
    
    return filename;

  }
  
  
  
  String [] getData(){
    
    //String [] data = {};
    ArrayList <String> rawData = new ArrayList<String>();

    //ArrayList <Path> pathes = pm.pathes;
    
    for(int cp = 0; cp < pm.pathes.size(); cp++){
      
      rawData.add("Path:" + cp);
      
      for(PathSegment currentSegment = pm.pathes.get(cp).start; currentSegment != null; currentSegment = currentSegment.nextSegment){
        
        rawData.add("Segment:" + currentSegment.id + ";P0:" + currentSegment.p0 + ";Pf:" + currentSegment.pf + ";col:" + currentSegment.col + ";PreviousSegment:" + (currentSegment.previousSegment == null ? null : currentSegment.previousSegment.id) + ";NextSegment:" + (currentSegment.nextSegment == null ? null : currentSegment.nextSegment.id));
      }
    }
    
    return rawData.toArray(new String[0]); 
  }
  
  
  String timestamp(){
    
    return hour() + "-" + minute() + "-" + second();
  }
  
}
