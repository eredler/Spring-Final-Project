Student[][] myStudents;
Button[][] myButtons; //same as students
int numRows,numCols;

import java.util.*;
import java.lang.*;
import controlP5.*;
ControlP5 cp5;
DropdownList dRow,dCol;
Slider row,col;

void setup(){
  size(1000,750);
  background(102,178,255);
  textAlign(CENTER,CENTER);
  cp5 = new ControlP5(this);
  //dRow = cp5.addDropdownList("numRows").setPosition(width/3 , height/2);
  //dCol = cp5.addDropdownList("numCols").setPosition(width*2/3 , height/2);
}

void draw(){
  askNumStudents();
}

void keyPressed(){
  
}

void keyReleased(){
  
}

void askNumStudents(){
  textSize(32);
  fill(255);
  text("StuySOS",width/2, height/4);
  dRow = cp5.addDropdownList("How many rows?").setPosition(width/3 , height/2);
  dCol = cp5.addDropdownList("How many seats per row?").setPosition(width*2/3 , height/2);
  //row = cp5.addSlider("How many rows?").setPosition(width/3 , height/2).setRange(1,10);
  //col = cp5.addSlider("Seats per row?").setPosition(width*2/3 , height/2).setRange(1,10);
}

//from cp5 site
void customize(DropdownList ddl, int min, int max) { //added min,max; assume min<=max
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(100);
  ddl.setBarHeight(75);
  ddl.captionLabel().set("dropdown");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  for (int i=min;i<=max;i++) {
    ddl.addItem("item "+i, i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}
