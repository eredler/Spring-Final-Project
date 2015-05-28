Student[][] myStudents;
Button[][] myButtons; //same as students

void setup(){
  size(1000,750);
  background(102,178,255);
}

void draw(){
  
}

void keyPressed(){
  
}

void keyReleased(){
  
}

//following code taken from my group's project from last semester
void display(){
  pushMatrix();
  translate(x,y);
  stroke(0);
  fill(strokeColor);
  polygon(0, 0, 80, 6);
  popMatrix();
}
  
void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + sin(a) * radius;
    float sy = y + cos(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
  
float[] findVertex(int vertex,int dXY){
  float[] coords = new float[4];
  if(vertex==1){
    coords[0]=x;
    coords[1]=y+dXY*80;
  }else if(vertex==2){
    coords[0]=x-dXY*40*sqrt(3);
    coords[1]=y+dXY*40;
  }else {
    coords[0]=x-dXY*40*sqrt(3);
    coords[1]=y-dXY*40;
  }
  return coords;
}
