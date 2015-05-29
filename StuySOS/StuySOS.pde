Student[][] myStudents;
Button[][] myButtons; //same as students
int numRows,numCols;

import java.util.*;
import java.lang.*;
import controlP5.*;
ControlP5 cp5;
DropdownList dRow,dCol;
Slider row,col;
String currScreen;
color buttonNotClicked, buttonClicked;

void setup(){
  size(1000,750);
  background(102,178,255);
  textAlign(CENTER,CENTER);
  cp5 = new ControlP5(this);
  //dRow = cp5.addDropdownList("numRows").setPosition(width/3 , height/2);
  //dCol = cp5.addDropdownList("numCols").setPosition(width*2/3 , height/2);
  currScreen="titleScreen";
  buttonNotClicked=color(51,255,153);
  buttonClicked=color(0,204,102);
}

void draw(){
  if (currScreen=="titleScreen"){
    titleScreen();
  }
}

void keyPressed(){
  
}

void keyReleased(){
  
}

void titleScreen(){
  askNumRows();
}

void askNumRows(){
  textSize(32);
  stroke(255,255,255);
  text("How many rows of students are there?",width/2,height/2);
  textSize(16);
  fill(buttonNotClicked);
  stroke(buttonNotClicked);
  for (int i=1;i<=8;i++){
    rect( width/2 + (30*((i%4)-2.5)) - 10, height/2 + (30*((i+3)/4)) -10 ,20,20,10);
  }
  for (int i=1;i<=8;i++){
    fill(255,255,255);
    text(""+i,width/2 + (30*(((i-1)%4)-2.5)), height/2 + (30*((i+3)/4)) );
  }
  noStroke();
  textSize(18);
}


boolean mouseOverCircle(float x, float y, float diameter) {
  return (dist(mouseX, mouseY, x, y) < diameter*0.5);
}
 
boolean mouseOverRect(float x, float y, float w, float h) {
  return (mouseX >= x-(w/2) && mouseX <= x+(w/2) && mouseY >= y-(h/2) && mouseY <= y+(h/2));
}
/*
void askNumStudents(){
  textSize(32);
  fill(255);
  text("StuySOS",width/2, height/4);
  dRow = cp5.addDropdownList("How many rows?").setPosition(width/3 , height/2);
  dCol = cp5.addDropdownList("How many seats per row?").setPosition(width*2/3 , height/2);
  customize(dRow,2,8,25,90);
  customize(dCol,2,8,25,130); //should row * col <= 40?
  
  //row = cp5.addSlider("How many rows?").setPosition(width/3 , height/2).setRange(1,10);
  //col = cp5.addSlider("Seats per row?").setPosition(width*2/3 , height/2).setRange(1,10);
}

//from cp5 site
void customize(DropdownList ddl, int min, int max, int h, int w) { //added min,max; assume min<=max
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(50);
  ddl.setBarHeight(h);
  ddl.setWidth(w);
  //ddl.captionLabel().set("dropdown");
  ddl.captionLabel().style().marginTop = 8;
  //ddl.captionLabel().style().marginLeft = 3;
  //ddl.valueLabel().style().marginTop = 3;
  ddl.actAsPulldownMenu(true);
  ArrayList<Integer> temp=new ArrayList<Integer>();
  for (int i=min;i<=max;i++) {
    ddl.addItem("item "+i, i);
     //temp.add(i);
  }
  //ddl.addItems(temp);
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
  //ddl.showScrollbar();
}
*/
