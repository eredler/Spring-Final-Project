Student[][] myStudents;
Button[][] myButtons; //same as students

import java.util.*;
import java.lang.*;
import controlP5.*;
DropdownList d;
void setup(){
  size(1000,750);
  background(102,178,255);
}

void draw(){
  display();
  ask
}

void keyPressed(){
  
}

void keyReleased(){
  
}

void askNumStudents(){
  textSize(32);
  fill(255);
  text("word",width/2, height/2); 
}


//following code taken from my group's project from last semester
void display(){
  pushMatrix();
  //translate(x,y);
  stroke(0);
  //fill(strokeColor);
  fill(153);
  rect(30, 20, 55, 55, 7);
  popMatrix();
}
