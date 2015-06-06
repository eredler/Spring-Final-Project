Student[][] myStudents;
Button[][] myButtons; //same as students
private int numRows, numCols;

import java.util.*;
import java.lang.*;
import controlP5.*;

ControlP5 cp5;
DropdownList dRow, dCol;
String currScreen;
color buttonNotClicked, buttonClicked;
float mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight;
color mainButtonColor;
ArrayList<Float> widths, heights; //for remembering titleScreen button positions
ArrayList<Float> studentBoxX, studentBoxY; //for remembering where students are on main classroom Screen
float studentBoxHeights, studentBoxWidths;
PImage chalkboard;
color beginButton=color(145, 114, 236);
ControllerGroup cg;
Slider row, col;
int currStudentRow, currStudentCol;

void setup() {
  size(1000, 750);
  background(102, 178, 255);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  cp5 = new ControlP5(this);
  //dRow = cp5.addDropdownList("numRows").setPosition(width/3 , height/2);
  //dCol = cp5.addDropdownList("numCols").setPosition(width*2/3 , height/2);
  currScreen="introScreen";
  buttonNotClicked=color(0, 128, 255);
  buttonClicked=color(0, 102, 204);
  widths=new ArrayList<Float>();
  heights=new ArrayList<Float>();
  studentBoxX=new ArrayList<Float>();
  studentBoxY=new ArrayList<Float>();
  chalkboard=loadImage("images/chalkboardPic.png");
  chalkboard.resize(width, height); 
  mainButtonX=width/12-30;
  mainButtonY=height/12-35;
  mainButtonWidth=75;
  mainButtonHeight=30;
  mainButtonColor=color(178,102,255);
  submitButtonColor=color(255,255,255);
  submitTextColor=color(30,205,151);
  errorMessage=false;
}

void draw() {
  //maybe add a main welcome page or something later
  if (currScreen=="introScreen") {
    introScreen();
  } else if (currScreen=="titleScreen1" || currScreen=="titleScreen2") {
    titleScreen();
    textSize(32);
    text("NumRows: "+numRows, 100, 100);
    text("NumCols: "+numCols, 500, 100);
  } else if (currScreen=="myClassroom") {
    classroomScreen();
  } else if (currScreen=="fillStudentInfo") {
    studentInfoScreen(currStudentRow,currStudentCol);
    //fillStudentInfoScreen(currStudentRow,currStudentCol);
    //cp5 = new ControlP5(this);
    //cp5.addTextfield("studentName").setPosition(100, 100).setSize(200, 50).setAutoClear(false);
    //cp5.addBang("Submit").setPosition(240, 170).setSize(80, 40);     
  }
}

void mouseClicked() {
  if (mouseOverRect(mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight)) {
    currScreen="introScreen";
  } else if (currScreen=="introScreen") {
    if (mouseOverRect(width/2, height/2+50, 100, 30)) {
      //beginButton=color(158,123,255);
      currScreen="titleScreen1";
    } else {
      beginButton=color(148, 114, 236);
    }
  }
  //TITLESCREEN1 = pick number of rows
  else if (currScreen=="titleScreen1") {
    for (int i=1; i<=8; i++) {
      if (25 >= Math.abs(widths.get(i-1) - mouseX) && 25 >= Math.abs(heights.get(i-1) - mouseY)) {
        numRows=i;
        break;
      }
    }
    if (numRows!=0){
      currScreen="titleScreen2";
    }
  } 
  //TITLESCREEN2 = pick number of seats per row
  else if (currScreen=="titleScreen2") {
    for (int i=1; i<=8; i++) {
      if (25 >= Math.abs(widths.get(i-1) - mouseX) && 25 >= Math.abs(heights.get(i-1) - mouseY)) {
        numCols=i;
        break;
      }
    } 
    //assume that at this point, have some working/legit value for numRows and numCols
    myStudents=new Student[numRows][numCols];
    for (Student[] studentGroup : myStudents) {
      for (Student s : studentGroup) {
        //s.setName("");
        s=new Student();
      }
    }
    if (numCols!=0){
      currScreen="myClassroom";
    }
  }else if (currScreen=="myClassroom") {
    for (int r=0; r<numRows; r++) {
      for (int c=0; c<numCols; c++) {
        if (studentBoxWidths >= Math.abs(width*(c+1)/(numCols+1) - mouseX) && studentBoxHeights >= Math.abs(width*(r+1)/(numRows+1) - mouseY)){
          currScreen="fillStudentInfo";
          currStudentRow=r;
          currStudentCol=c;
        }
      }
    }
  }else if (currScreen=="fillStudentInfo"){
    boolean action=false;
    //if (myStudents[currStudentRow][currStudentCol].getName().equals("")){
        //typing="";
    //}
    if (mouseOverRect(width/2, height/2+100, 75, 30)){ //SUBMIT
      if (typing.length()<1){
        errorMessage=true;
      }else{
        myStudents[currStudentRow+1][currStudentCol].setName(typing);
        action=true;
      }
    }else if (mouseOverRect(width/2, height/2+150, 75, 30)){ //CLEAR
      typing="";
      errorMessage=false;
    }else if (mouseOverRect(width/2, height/2+200, 75, 30)){ //GO BACK
      typing="";
      errorMessage=false;
      currScreen="myClassroom";
    }
    if(action){
      //currScreen= "WHATEVER NAME OF NEXT SCREEN IS";
     currScreen="myClassroom"; //maybe next step of studentInfo? 
    }
  }
}

void introScreen() {
  background(chalkboard);
  fill(255);
  textSize(48);
  text("Welcome to StuySOS!", width/2, height/2);
  noStroke();
  //color beginButton=color(145,114,236);
  fill(beginButton);
  rect(width/2, height/2+50, 100, 30, 10);//-47, height/2+37, 100, 30, 10);
  fill(255);
  textSize(20);
  text("Begin", width/2, height/2+48);

  if (mouseOverRect(width/2, height/2+50, 100, 30)) {
    beginButton=color(158, 123, 255);
  } else {
    beginButton=color(148, 114, 236);
  }
}

void titleScreen() {
  background(chalkboard);
  textSize(24);
  stroke(255, 255, 255);
  String message="Something is not working if this appears";
  if (currScreen=="titleScreen1") {
    message="How many rows of students are there?";
  } else if (currScreen=="titleScreen2") {
    message="How many seats per row?";
  }
  text(message, width/2, height/2-10);
  textSize(16);
  fill(buttonNotClicked);
  stroke(buttonNotClicked);
  for (int i=1; i<=8; i++) {
    float x=width*i/9;
    //float h=height/2 + (30*((i+3)/4));
    float y=height/2+50;
    widths.add(x);//+25);
    heights.add(y);//+23);
    rect(x, y, 50, 50, 10);
    //rect(width/2 + (30*((i%4)-2.5)) - 10,height/2 + (30*((i+3)/4)) -10,20,20,10);
  }
  for (int i=1; i<=8; i++) {
    fill(255, 255, 255);
    //text(""+i,width/2 + (30*(((i-1)%4)-2.5)), height/2 + (30*((i+3)/4)) );
    text(""+i, widths.get(i-1), heights.get(i-1));
  }
  noStroke();
  textSize(18);
  mainButton();
}

void classroomScreen() {
  background(102, 158, 242);
  studentBoxHeights=(height-50)/(numRows+5);
  studentBoxWidths=(width-50)/(numCols+5);
  for (int r=0; r<numRows; r++) {
    for (int c=0; c<numCols; c++) {
      String studentName="EMPTY";
      if (myStudents[r][c]==null) {
        myStudents[r][c]=new Student();
        studentName=myStudents[r][c].getName();
      }else if (!myStudents[r][c].getName().equals("")){
        studentName=myStudents[r][c].getName();  
      }
      float x= (width*(c+1)/(numCols+1));
      float y= (height*(r+1)/(numRows+1));
      studentBoxX.add(x);
      studentBoxY.add(y);
      stroke(230,15,10);
      fill(242,158,102);
      //rect((width*(c+1)/(numCols+1)), (height*(r+1)/(numRows+1)), studentBoxWidths, studentBoxHeights, 10);
      rect(x,y,studentBoxWidths,studentBoxHeights,10);
      noStroke();
      fill(0);
      if (numRows*numCols <=15) {
        textSize(24);
      } else {
        textSize(16);
      }
      text(studentName, width*(c+1)/(numCols+1), height*(r+1)/(numRows+1));
    }
  }
  mainButton();
}

void fillStudentInfoScreen(int currR, int currC) {
  background(102, 158, 242);

  askStudentInfo(currR, currC, numCols*(currR)+currC+1);
  
  //Just to check that right student was being clicked on
  //text("Row: "+currStudentRow,width/2,height/2+50);
  //text("Col: "+currStudentCol,width/2,height/2 +70);
  
  mainButton();
}

//===HELPFUL STUFF===//
boolean mouseOverCircle(float x, float y, float diameter) {
  return (dist(mouseX, mouseY, x, y) < diameter*0.5);
}

boolean mouseOverRect(float x, float y, float w, float h) {
  return (mouseX >= x-(w/2) && mouseX <= x+(w/2) && mouseY >= y-(h/2) && mouseY <= y+(h/2));
}

void mainButton() {
  noStroke();
  textSize(18);
  fill(mainButtonColor);
  rect(mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight, 12);
  fill(255, 255, 255);
  text("MAIN", mainButtonX, mainButtonY);

  if (mouseOverRect(mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight)) {
    mainButtonColor=color(153, 51, 255);
  } else {
    mainButtonColor=color(178, 102, 255);
  }
}

void askStudentInfo(int row, int seat, int num) {
  textSize(24);
  fill(255);
  String s = "Please input info for student " + num + ".";
  text(s, width/2, height/2);
}

void Submit() {
  print("the following text was submitted :");
  String blah = cp5.get(Textfield.class,"studentName").getText();
  print("studentName = " + blah);
  println();
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
  for (int i=min; i<=max; i++) {
    ddl.setItemHeight(100);
    ddl.setBarHeight(75);
    ddl.captionLabel().set("dropdown");
    ddl.captionLabel().style().marginTop = 3;
    ddl.captionLabel().style().marginLeft = 3;
    ddl.valueLabel().style().marginTop = 3;
    for (int y=min; y<=max; y++) {
      ddl.addItem("item "+y, y);
      //temp.add(i);
    }
    //ddl.addItems(temp);
    //ddl.scroll(0);
    ddl.setColorBackground(color(60));
    ddl.setColorActive(color(255, 128));
    //ddl.showScrollbar();
  }
}

