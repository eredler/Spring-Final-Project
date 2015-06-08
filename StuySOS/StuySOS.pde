Student[][] myStudents;
Button[][] myButtons; //same as students
private int numRows, numCols;

import java.util.*;
import java.lang.*;

String currScreen, studentInfoMode;
color buttonNotClicked, buttonClicked;
float mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight;
color mainButtonColor, AttButtonColor, AttSubButtonColor, backColor, switchColor, switchSubColor;
ArrayList<Float> widths, heights; //for remembering titleScreen button positions
ArrayList<Float> studentBoxX, studentBoxY; //for remembering where students are on main classroom Screen
float studentBoxHeights, studentBoxWidths;
PImage chalkboard;
color beginButton=color(145, 114, 236);
int currStudentRow, currStudentCol, numStudentsSwitched;
boolean attendance, switchSeats;



void setup() {
  size(1000, 750);
  background(102, 178, 255);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);

  currScreen="introScreen";
  studentInfoMode="";
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
  switchColor=color(178, 102, 255);
  switchSubColor=color(178, 102, 255);
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
    if (studentInfoMode=="newStudent") {
      studentInfoScreen(currStudentRow, currStudentCol, myStudents);
    } else if (studentInfoMode=="currentStudent") {
      loadStudentInfo(currStudentRow, currStudentCol);
    }
    fillStudentInfoScreen(currStudentRow, currStudentCol);
  } else if (currScreen=="studentInfo") {
    studentInfoScreen(currStudentRow, currStudentCol, myStudents);
  } /*else if (currScreen=="addGradeHW") {
   addGradeScreen("Homework");
   } else if (currScreen=="addGradeParticipation") {
   addGradeScreen("Participation");
   } else if (currScreen=="addGradeTest") {
   addGradeScreen("Test");
   } else if (currScreen=="addGradeOther") {
   addGradeScreen("Other");
   }*/
}

void mouseClicked() {
  if (mouseOverRect(mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight)) {
    currScreen="introScreen";
  } else if (currScreen=="introScreen") {
    if (mouseOverRect(width/2, height/2+70, 100, 30)) {
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
    for (int r=0; r<numRows; r++) {
      for (int c=0; c<numCols; c++) {
        if (studentBoxWidths >= Math.abs(studentBoxX.get(numCols*(r)+c)-mouseX) && studentBoxHeights >= Math.abs(studentBoxY.get(numCols*(r)+c)-mouseY)) {
          //Math.abs(width*(c+1)/(numCols+1) - mouseX) && studentBoxHeights >= Math.abs(width*(r+1)/(numRows+1) - mouseY)){
          currScreen="fillStudentInfo";
          currStudentRow=r;
          currStudentCol=c;
          if (myStudents[currStudentRow][currStudentCol].getName().equals("")) {
            studentInfoMode="newStudent";
          } else {
            studentInfoMode="currentStudent";
          }
        }
      }
    }
    //} else if (currScreen=="myClassroom") {
    if (attendance == false && switchSeats==false) {
      if (mouseOverRect(mainButtonX+60, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
        attendance=true;
      }
      if (mouseOverRect(mainButtonX+250, mainButtonY+50, mainButtonWidth+100, mainButtonHeight)) {
        switchSeats=true;
        numStudentsSwitched = 0;
      }
      /*
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
       */
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
    if (switchSeats) {
      if (numStudentsSwitched < 2) {
        for (int r=0; r<numRows; r++) {
          for (int c=0; c<numCols; c++) {
            if (studentBoxWidths >= Math.abs(studentBoxX.get(numCols*(r)+c)-mouseX) && studentBoxHeights >= Math.abs(studentBoxY.get(numCols*(r)+c)-mouseY)) {
              //Math.abs(width*(c+1)/(numCols+1) - mouseX) && studentBoxHeights >= Math.abs(width*(r+1)/(numRows+1) - mouseY)){
              myStudents[r][c].switchMe = true;
              currStudentRow=r;
              currStudentCol=c;
              numStudentsSwitched++;
            }
          }
        }
      }
      if (mouseOverRect(mainButtonX, mainButtonY+100, mainButtonWidth, mainButtonHeight)) {
        if (numStudentsSwitched == 2) {
          int holdR1 = 0;
          int holdR2 = 0;
          int holdC1= 0;
          int holdC2= 0;
          for (int r=0; r<numRows; r++) {
            for (int c=0; c<numCols; c++) {
              if (myStudents[r][c].switchMe == true) {
                if (numStudentsSwitched ==2) {
                  holdR1 = r;
                  holdC1 = c; 
                  numStudentsSwitched--;
                  myStudents[r][c].switchMe = false;
                }
                if (numStudentsSwitched==1) {
                  holdR2 = r;
                  holdC2 = c; 
                  myStudents[r][c].switchMe = false;
                }
              }
            }
          }
          Student hold1 = myStudents[holdR1][holdC1];
          myStudents[holdR1][holdC1] = myStudents[holdR2][holdC2];
          myStudents[holdR2][holdC2] = hold1;
          switchSeats=false;
        }
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
  text("Exit", mainButtonX, mainButtonY);

  if (mouseOverRect(mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight)) {
    mainButtonColor=color(153, 51, 255);
  } else {
    mainButtonColor=color(178, 102, 255);
  }/*
  if (currScreen == "myClassroom") {
   if (mouseOverRect(mainButtonX+60, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
   AttButtonColor=color(153, 51, 255);
   } else {
   AttButtonColor=color(178, 102, 255);
   }
   if (mouseOverRect(mainButtonX, mainButtonY+100, mainButtonWidth, mainButtonHeight)) {
   AttSubButtonColor=color(153, 51, 255);
   } else {
   AttSubButtonColor=color(178, 102, 255);
   }
   if (mouseOverRect(mainButtonX+250, mainButtonY+50, mainButtonWidth+80, mainButtonHeight)) {
   switchColor=color(153, 51, 255);
   } else {
   switchColor=color(178, 102, 255);
   }
   }
   if (currScreen=="studentInfo") {
   if (mouseOverRect(mainButtonX, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
   backColor=color(153, 51, 255);
   } else {
   backColor=color(178, 102, 255);
   }
   }*/
}

public void test() {
  System.out.println(myStudents.toString());
}


