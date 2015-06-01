Student[][] myStudents;
Button[][] myButtons; //same as students
private int numRows, numCols;

import java.util.*;
import java.lang.*;
import controlP5.*;

ControlP5 cp5;
DropdownList dRow,dCol;
String currScreen;
color buttonNotClicked, buttonClicked;
float mainButtonX,mainButtonY,mainButtonWidth,mainButtonHeight;
color mainButtonColor;
ArrayList<Float> widths,heights; //for remembering titleScreen button positions
ArrayList<Float> studentBoxX,studentBoxY; //for remembering where students are on main classroom Screen
float studentBoxHeights,studentBoxWidths;
PImage chalkboard;
color beginButton=color(145,114,236);
ControllerGroup cg;
Slider row, col;

void setup() {
  size(1000, 750);
  background(102, 178, 255);
  textAlign(CENTER, CENTER);
  cp5 = new ControlP5(this);
  //dRow = cp5.addDropdownList("numRows").setPosition(width/3 , height/2);
  //dCol = cp5.addDropdownList("numCols").setPosition(width*2/3 , height/2);
  currScreen="introScreen";
  buttonNotClicked=color(0,128,255);
  buttonClicked=color(0,102,204);
  widths=new ArrayList<Float>();
  heights=new ArrayList<Float>();
  chalkboard=loadImage("images/chalkboardPic.png");
  chalkboard.resize(width,height);
}

void draw(){
  //maybe add a main welcome page or something later
  if (currScreen=="introScreen"){
    introScreen(); 
  }
  else if (currScreen=="titleScreen1" || currScreen=="titleScreen2"){
    titleScreen();
    textSize(32);
    text("NumRows: "+numRows,100,100);
    text("NumCols: "+numCols,500,100);
  }
  else if (currScreen=="myClassroom"){
    classroomScreen(); 
  }
}

void mouseClicked(){
  if (mouseOverRect(mainButtonX,mainButtonY,mainButtonWidth,mainButtonHeight)){
      currScreen="introScreen";  
  }
  else if (currScreen=="introScreen"){
    if (mouseOverRect(width/2,height/2+50,100,30)){
      //beginButton=color(158,123,255);
      currScreen="titleScreen1";
    }else{
      beginButton=color(148,114,236);
    }
  }
  //TITLESCREEN1 = pick number of rows
  else if (currScreen=="titleScreen1"){
    for (int i=1;i<=8;i++){
      if (30 >= Math.abs(widths.get(i-1) - mouseX) && 30 >= Math.abs(heights.get(i-1) - mouseY)){
        numRows=i;
        break; 
      }
    }
    currScreen="titleScreen2";
  } 
  //TITLESCREEN2 = pick number of seats per row
  else if (currScreen=="titleScreen2"){
     for (int i=1;i<=8;i++){
      if (30 >= Math.abs(widths.get(i-1) - mouseX) && 30 >= Math.abs(heights.get(i-1) - mouseY)){
        numCols=i;
        break; 
      }
    } 
    //assume that at this point, have some working/legit value for numRows and numCols
    myStudents=new Student[numRows][numCols];
    for (Student[] studentGroup:myStudents){
      for (Student s: studentGroup){
        //s.setName("");
        s=new Student();
      }
    }
    currScreen="myClassroom";
  }
  else if (currScreen=="myClassroom"){
    //do something
  }
}

void introScreen(){
  background(chalkboard);
  fill(255);
  textSize(48);
  text("Welcome to StuySOS!",width/2,height/2);
  noStroke();
  //color beginButton=color(145,114,236);
  fill(beginButton);
  rect(width/2-47, height/2+37,100,30,10);
  fill(255);
  textSize(20);
  text("Begin",width/2,height/2+48);
  
  if (mouseOverRect(width/2,height/2+50,100,30)){
    beginButton=color(158,123,255);
  }else{
    beginButton=color(148,114,236);
  }

}

void titleScreen(){
  background(chalkboard);
  textSize(24);
  stroke(255,255,255);
  String message="Something is not working if this appears";
  if (currScreen=="titleScreen1"){
    message="How many rows of students are there?";
  }else if (currScreen=="titleScreen2"){
    message="How many seats per row?";
  }
  text(message,width/2,height/2-10);
  textSize(16);
  fill(buttonNotClicked);
  stroke(buttonNotClicked);
  for (int i=1;i<=8;i++){
    float x=width*i/9;
    //float h=height/2 + (30*((i+3)/4));
    float y=height/2+50;
    widths.add(x+25);
    heights.add(y+23);
    rect(x,y,50,50,10);
    //rect(width/2 + (30*((i%4)-2.5)) - 10,height/2 + (30*((i+3)/4)) -10,20,20,10);
  }
  for (int i=1;i<=8;i++){
    fill(255,255,255);
    //text(""+i,width/2 + (30*(((i-1)%4)-2.5)), height/2 + (30*((i+3)/4)) );
    text(""+i,widths.get(i-1),heights.get(i-1));
  }
  noStroke();
  textSize(18);
  mainButton();
}

void classroomScreen(){
  background(102,158,242);
  studentBoxHeights=(height-50)/(numRows+5);
  studentBoxWidths=(width-50)/(numCols+5);
  for (int r=0;r<numRows;r++){
    for (int c=0;c<numCols;c++){
      String studentName="EMPTY";
      //if (myStudents[r][c].getName()==null){
        //studentName="EMPTY";
      //}else{
      //if (myStudents[r][c].getName()!=""){
      if(myStudents[r][c]==null){
        myStudents[r][c]=new Student();
        studentName=myStudents[r][c].getName();
      }
      //float x= width*c/numCols;
      //float y= height*r/numRows+20;
      //studentBoxX.add(x);
      //studentBoxY.add(y);
      fill(255);
      rect((width*(c+1)/(numCols+1))-49,(height*(r+1)/(numRows+1))-33,studentBoxWidths,studentBoxHeights,10);
      fill(0);
      //textSize(200/(numRows*numCols));
      if (numRows*numCols <=15){
        textSize(24); 
      }else{
        textSize(16);
      }
      text(studentName,width*(c+1)/(numCols+1),height*(r+1)/(numRows+1)); 
    }
  }
  mainButton();
}

//===HELPFUL STUFF===//
boolean mouseOverCircle(float x, float y, float diameter) {
  return (dist(mouseX, mouseY, x, y) < diameter*0.5);
}
 
boolean mouseOverRect(float x, float y, float w, float h) {
  return (mouseX >= x-(w/2) && mouseX <= x+(w/2) && mouseY >= y-(h/2) && mouseY <= y+(h/2));
}

void mainButton(){
  noStroke();
  textSize(18);
  fill(mainButtonColor);
  rect(mainButtonX,mainButtonY,mainButtonWidth,mainButtonHeight,12);
  fill(255,255,255);
  text("MAIN",mainButtonX,mainButtonY-3);
  
  if (mouseOverRect(mainButtonX,mainButtonY,mainButtonWidth,mainButtonHeight)){
    mainButtonColor=color(153,51,255);
  }
  else{
    mainButtonColor=color(178,102,255);
  }  
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
}
void draw() {
  askNumStudents();
}

void keyPressed() {
}

void keyReleased() {
}

void setNumRows(int r) {
  numRows = r;
}

void setNumCols(int c) {
  numCols = c;
}

int getNumRows() {
  return numRows;
}

int getNumCols() {
  return numCols;
}

void askNumStudents() {
  textSize(32);
  fill(255);
  text("StuySOS", width/2, height/4);
  dRow = cp5.addDropdownList("How many rows?").setPosition(width/3, height/2);
  dCol = cp5.addDropdownList("How many seats per row?").setPosition(width*2/3, height/2);
  //row = cp5.addSlider("How many rows?").setPosition(width/3 , height/2).setRange(1,10);
  //col = cp5.addSlider("Seats per row?").setPosition(width*2/3 , height/2).setRange(1,10);
}

int getNumStudents() {
  int ans = 0;
  for (int i = 0; i < getNumRows (); i++) {
    for (int c = 0; c < getNumCols (); c++) {
      if (myStudents[i][c] != null) {
        ans++;
      }
    }
  }
  return ans;
}

void askStudentInfo(int row, int seat, int num) {
  textSize(24);
  fill(255);
  String s = "Please input info for student " + num + ".";
  text(s,width/2,height/2);
  Textfield studentName = new Textfield(cp5, cg, "studentName","No name",100,100,200,50);
}

void fillClass() {
  int num = 1;
  for (int i = 0; i < getNumRows (); i++) {
    for (int c = 0; c < getNumCols (); c++) {
      askStudentInfo(i, c, num);
      num++;
    }
  }
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
  ddl.setItemHeight(100);
  ddl.setBarHeight(75);
  ddl.captionLabel().set("dropdown");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  for (int i=min; i<=max; i++) {
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
