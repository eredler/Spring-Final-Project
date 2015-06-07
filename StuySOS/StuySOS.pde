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
color mainButtonColor, AttButtonColor, AttSubButtonColor, backColor;
ArrayList<Float> widths, heights; //for remembering titleScreen button positions
ArrayList<Float> studentBoxX, studentBoxY; //for remembering where students are on main classroom Screen
float studentBoxHeights, studentBoxWidths;
PImage chalkboard;
color beginButton=color(145, 114, 236);
ControllerGroup cg;
Slider row, col;
int currStudentRow, currStudentCol;
boolean attendance;



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
  mainButtonColor=color(178, 102, 255);
  AttButtonColor=color(178, 102, 255);
  AttSubButtonColor=color(178, 102, 255);
  backColor=color(178, 102, 255);
  submitButtonColor=color(255, 255, 255);
  submitTextColor=color(30, 205, 15);
  errorMessage=false;
}

void draw() {
  //maybe add a main welcome page or something later
  if (currScreen=="introScreen") {
    introScreen();
  } else if (currScreen=="titleScreen1" || currScreen=="titleScreen2") {
    titleScreen();
    textSize(32);
    // text("NumRows: "+numRows, 100, 100);
    //  text("NumCols: "+numCols, 500, 100);
  } else if (currScreen=="myClassroom") {
    classroomScreen();
  } else if (currScreen=="fillStudentInfo") {
    fillStudentInfoScreen(currStudentRow, currStudentCol);
    //fillStudentInfoScreen(currStudentRow,currStudentCol);
    //cp5 = new ControlP5(this);
    //cp5.addTextfield("studentName").setPosition(100, 100).setSize(200, 50).setAutoClear(false);
    //cp5.addBang("Submit").setPosition(240, 170).setSize(80, 40);
  } else if (currScreen=="studentInfo") {
    studentInfoScreen(currStudentRow, currStudentCol, myStudents);
  } else if (currScreen=="addGradeHW") {
    addGradeScreen("Homework");
  } else if (currScreen=="addGradeParticipation") {
    addGradeScreen("Participation");
  } else if (currScreen=="addGradeTest") {
    addGradeScreen("Test");
  } else if (currScreen=="addGradeOther") {
    addGradeScreen("Other");
  }
}

void mouseClicked() {
  if (mouseOverRect(mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight)) {
    currScreen="introScreen";
  } else if (currScreen=="introScreen") {
    if (mouseOverRect(width/2, height/2+70, 100, 30)) {
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
    if (numRows!=0) {
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
    if (numCols!=0) {
      currScreen="myClassroom";
    }
  } else if (currScreen=="myClassroom") {
    if (attendance == false) {
      if (mouseOverRect(mainButtonX+60, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
        attendance=true;
      }
      for (int r=0; r<numRows; r++) {
        for (int c=0; c<numCols; c++) {
          if (studentBoxWidths >= Math.abs(studentBoxX.get(numCols*(r)+c)-mouseX) && studentBoxHeights >= Math.abs(studentBoxY.get(numCols*(r)+c)-mouseY)) {
            //Math.abs(width*(c+1)/(numCols+1) - mouseX) && studentBoxHeights >= Math.abs(width*(r+1)/(numRows+1) - mouseY)){
            currScreen="studentInfo";
            currStudentRow=r;
            currStudentCol=c;
          }
        }
      }
    } else if (attendance) {
      for (int r=0; r<numRows; r++) {
        for (int c=0; c<numCols; c++) {
          if (studentBoxWidths >= Math.abs(studentBoxX.get(numCols*(r)+c)-mouseX) && studentBoxHeights >= Math.abs(studentBoxY.get(numCols*(r)+c)-mouseY)) {
            //Math.abs(width*(c+1)/(numCols+1) - mouseX) && studentBoxHeights >= Math.abs(width*(r+1)/(numRows+1) - mouseY)){
            myStudents[r][c].numClicks++;
            currStudentRow=r;
            currStudentCol=c;
          }
        }
      }
      if (mouseOverRect(mainButtonX, mainButtonY+100, mainButtonWidth, mainButtonHeight)) {
        for (int r=0; r<numRows; r++) {
          for (int c=0; c<numCols; c++) {
            if (myStudents[r][c].numClicks%3==1) {
              myStudents[r][c].setNumLate(myStudents[r][c].getNumLate()+1);
              myStudents[r][c].numClicks=0;
            } else if (myStudents[r][c].numClicks%3==2) {
              myStudents[r][c].setNumAbsent(myStudents[r][c].getNumAbsent()+1);
              myStudents[r][c].numClicks=0;
            }
          }
        }
        attendance=false;
      }
    }
  } else if (currScreen=="studentInfo") {
    if (mouseOverRect(width/2, height/2+100, 75, 30)) { //EDIT INFO
      currScreen = "fillStudentInfo";
    }
    if (mouseOverRect(mainButtonX, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
      currScreen="myClassroom";
    } /*else if (mouseOverRect(width/2, height/2+150, 150, 30)) { //add homework
     currScreen = "addGradeHW";
     } else if (mouseOverRect(width/2, height/2+200, 150, 30)) { //add test
     currScreen = "addGradeTest";
     } else if (mouseOverRect(width/2, height/2+250, 150, 30)) { //add participation
     currScreen = "addGradeParticipation";
     } else if (mouseOverRect(width/2, height/2+300, 150, 30)) { //add other grade
     currScreen = "addGradeOther";
     }
     } else if (currScreen=="addGradeHW") {
     boolean action=false;
     //if (myStudents[currStudentRow][currStudentCol].getName().equals("")){
     //typing="";
     //}
     if (mouseOverRect(width/2, height/2+100, 75, 30)) { //SUBMIT
    /* if (name.length()<1) {
     errorMessage=true;
     } else {
     myStudents[currStudentRow][currStudentCol].addGrade("Homework", title, Integer.parseInt(gradeV));
     action=true;
     //   }
     } else if (mouseOverRect(width/2, height/2+150, 75, 30)) { //&& myStudents[currStudentRow][currStudentCol].getName().equals("")){ //CLEAR
     // CLEAR
     title="";
     gradeV="";
     errorMessage=false;
     action=false; //JUST TO MAKE SURE
     } else if (mouseOverRect(width/2, height/2+200, 75, 30)) { //GO BACK
     title="";
     gradeV="";
     errorMessage=false;
     currScreen="myClassroom";
     action=true;
     }
     if (action) {
     //currScreen= "WHATEVER NAME OF NEXT SCREEN IS";
     currScreen="myClassroom"; //maybe next step of studentInfo?
     }
     } else if (currScreen=="addGradeTest") {
     } else if (currScreen=="addGradeParticipation") {
     } else if (currScreen=="addGradeOther") {*/
  } else if (currScreen=="fillStudentInfo") {
    boolean action=false;
    //if (myStudents[currStudentRow][currStudentCol].getName().equals("")){
    //typing="";
    //}
    if (mouseOverRect(width/2, height/2+100, 75, 30)) { //SUBMIT
      if (typing.length()<1) {
        errorMessage=true;
      } else {
        myStudents[currStudentRow][currStudentCol].setName(typing);
        action=true;
      }
    } else if (mouseOverRect(width/2, height/2+150, 75, 30)) { //&& myStudents[currStudentRow][currStudentCol].getName().equals("")){ //CLEAR
      // CLEAR
      typing="";
      errorMessage=false;
      action=false; //JUST TO MAKE SURE
    } else if (mouseOverRect(width/2, height/2+200, 75, 30)) { //GO BACK
      typing="";
      errorMessage=false;
      //currScreen="myClassroom";
      action=true;
    }
    if (action) {
      //currScreen= "WHATEVER NAME OF NEXT SCREEN IS";
      currScreen="myClassroom"; //maybe next step of studentInfo?
    }
  }
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
  if (currScreen == "myClassRoom") {
    if (mouseOverRect(mainButtonX+60, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
      AttButtonColor=color(153, 51, 255);
    } else {
      AttButtonColor=color(178, 102, 255);
    }
    if (mouseOverRect(mainButtonX+60, mainButtonY+100, mainButtonWidth+120, mainButtonHeight)) {
      AttSubButtonColor=color(153, 51, 255);
    } else {
      AttSubButtonColor=color(178, 102, 255);
    }
  }
  if (currScreen=="studentInfo") {
    if (mouseOverRect(mainButtonX, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
      backColor=color(153, 51, 255);
    } else {
      backColor=color(178, 102, 255);
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

