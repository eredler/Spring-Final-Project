Student[][] myStudents;
private int numRows, numCols;

import java.util.*;
import java.lang.*;
import java.io.*;

String currScreen;
color buttonNotClicked, buttonClicked;
float mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight;
color mainButtonColor, AttButtonColor, AttSubButtonColor, backColor, switchColor, switchSubColor;
ArrayList<Float> widths, heights; //for remembering titleScreen button positions
ArrayList<Float> studentBoxX, studentBoxY; //for remembering where students are on main classroom Screen
float studentBoxHeights, studentBoxWidths;
PImage chalkboard;
color beginButton=color(145, 114, 236), loadButton=color(145,114,236);
int currStudentRow, currStudentCol, numStudentsSwitched;
boolean attendance, switchSeats;

void setup() {
  size(1000, 750);
  background(102, 178, 255);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  cursor(CROSS); //COOL FEATURE: not necessary, but looks like a cool target practice thing with the mouse :)

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
  switchColor=color(178, 102, 255);
  switchSubColor=color(178, 102, 255);
  submitButtonColor=color(255, 255, 255);
  submitTextColor=color(30, 205, 15);
  errorMessage=false;
}

void draw() {
  if (currScreen=="introScreen") {
    introScreen();
  } else if (currScreen=="titleScreen1" || currScreen=="titleScreen2") {
    titleScreen();
    textSize(32);
  } else if (currScreen=="myClassroom") {
    classroomScreen();
  } else if (currScreen=="fillStudentInfo") {
    fillStudentInfoScreen(currStudentRow, currStudentCol);
  } else if (currScreen=="studentInfo") {
    studentInfoScreen(currStudentRow, currStudentCol, myStudents);
  } else if(currScreen=="studentGrades"){
    studentGradeScreen();
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
  if (mouseOverRect(mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight) && currScreen!="introScreen") {
    System.exit(0);
  }
  
  //WELCOME Screen
  else if (currScreen=="introScreen") {
    if (mouseOverRect(width/2, height/2+70, 100, 30)) { //BEGIN
      currScreen="titleScreen1";
    } else {
      beginButton=color(148, 114, 236);
    }
  }
  
  //TITLESCREEN1 = pick number of rows
  else if (currScreen=="titleScreen1") {
    for (int i=1; i<=8; i++) {
      if (mouseOverRect(widths.get(i-1),heights.get(i-1),50,50)){
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
    myStudents=new Student[numRows][numCols];
    for (Student[] studentGroup : myStudents) {
      for (Student s : studentGroup) {
        s=new Student();
      }
    }
    if (numCols!=0) {
      currScreen="myClassroom";
    }
  }
  
  //CLASSROOM Screen = shows all students currently enrolled in your class
  else if (currScreen=="myClassroom") {
    if (attendance == false && switchSeats==false) {
      if (mouseOverRect(mainButtonX+60, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
        attendance=true;
      } else if (mouseOverRect(mainButtonX+250, mainButtonY+50, mainButtonWidth+80, mainButtonHeight)) {
        switchSeats=true;
        numStudentsSwitched = 0;
      }
    }

    //TAKING ATTENDANCE
    if (attendance) {
      for (int r=0; r<numRows; r++) {
        for (int c=0; c<numCols; c++) {
          if (studentBoxWidths >= Math.abs(studentBoxX.get(numCols*(r)+c)-mouseX) && studentBoxHeights >= Math.abs(studentBoxY.get(numCols*(r)+c)-mouseY)) {
            myStudents[r][c].numClicks++;
            currStudentRow=r;
            currStudentCol=c;
          }
        }
      }
      if (mouseOverRect(mainButtonX, mainButtonY+100, mainButtonWidth, mainButtonHeight)) { //mouse is over SUBMIT attendance button
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

    //SWITCHING SEATS
    if (switchSeats) {
      if (numStudentsSwitched < 2) {
        for (int r=0; r<numRows; r++) {
          for (int c=0; c<numCols; c++) {
            if (studentBoxWidths >= Math.abs(studentBoxX.get(numCols*(r)+c)-mouseX) && studentBoxHeights >= Math.abs(studentBoxY.get(numCols*(r)+c)-mouseY)) {
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
    //IF JUST ENTERING NEW STUDENT OR LOOKING AT A CURRENT STUDENT'S INFO
    else if (!attendance && !switchSeats) {
      for (int r=0; r<numRows; r++) {
        for (int c=0; c<numCols; c++) {
          if (studentBoxWidths >= Math.abs(studentBoxX.get(numCols*(r)+c)-mouseX) && studentBoxHeights >= Math.abs(studentBoxY.get(numCols*(r)+c)-mouseY)) {
            currStudentRow=r;
            currStudentCol=c;
            if (myStudents[currStudentRow][currStudentCol].getName().equals("")) {
              currScreen="fillStudentInfo";
            } else {
              currScreen="studentInfo";
            }
          }
        }
      }
    }
  }
  
  //STUDENT INFORMATION Screen = looking at/editing a selected student's information 
  else if (currScreen=="studentInfo") {
    if (mouseOverRect(mainButtonX, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) { //BACK Button
      currScreen="myClassroom";
    } 
    if (mouseOverRect(width/2, height/2+50, 75, 30)) { //EDIT INFO
      currScreen = "fillStudentInfo";
      typing=myStudents[currStudentRow][currStudentCol].getName();
    }else if(mouseOverRect(width/2,height/2+100, 150, 30)){
      currScreen = "studentGrades";
    }else if (mouseOverRect(width/2, height/2+150, 150, 30)) { //add homework
      currScreen = "addGradeHW";
    } else if (mouseOverRect(width/2, height/2+200, 150, 30)) { //add test
      currScreen = "addGradeTest";
    } else if (mouseOverRect(width/2, height/2+250, 150, 30)) { //add participation
      currScreen = "addGradeParticipation";
    } else if (mouseOverRect(width/2, height/2+300, 150, 30)) { //add other grade
      currScreen = "addGradeOther";
    }
  } 
  
  //VIEW GRADES screen= can view a student's grades and their GPA (out of 100)
  else if (currScreen=="studentGrades"){
    if (mouseOverRect(mainButtonX, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) { //BACK Button
      currScreen="studentInfo";
    }
  }
  
  //ADD GRADE screen
  else if (currScreen.substring(0,8).equals("addGrade")){ //any of the addGrade screens (hw, participation, test, or other)
    if (mouseOverRect(width/2, height/2, 150, 35)){ //Grade value box
      currTextMode="gradeV";      
    } if(mouseOverRect(width/2, height/2+50, 150, 35)){ //Grade type/name box
      currTextMode="title";
    } else if (mouseOverRect(width/2, height/2+100, 75, 30)) { //SUBMIT
      if (title.length()<1 || gradeV.length()<1 || Integer.parseInt(gradeV)>100) {
        errorMessage=true;
      } else {
        errorMessage=false;
        myStudents[currStudentRow][currStudentCol].addGrade("Grade", title, Integer.parseInt(gradeV));
        title="";
        gradeV="";
        currScreen="studentInfo";
      } 
    } else if (mouseOverRect(width/2, height/2+150, 75, 30)) { //CLEAR
      title="";
      gradeV="";
      errorMessage=false;
    } else if (mouseOverRect(width/2, height/2+200, 75, 30)) { //GO BACK
      title="";
      gradeV="";
      errorMessage=false;
      currScreen="studentInfo";
    }
  } 
  
  //FILL STUDENT INFO screen= filling out info for new students
  else if (currScreen=="fillStudentInfo") {
    boolean action=false;
    if (mouseOverRect(width/2, height/2+100, 75, 30)) { //SUBMIT
      if (typing.length()<1) {
        errorMessage=true;
      } else {
        myStudents[currStudentRow][currStudentCol].setName(typing);
        typing="";
        action=true;
      }
    } else if (mouseOverRect(width/2, height/2+150, 75, 30)) { //CLEAR
      typing="";
      errorMessage=false;
      action=false;
    } else if (mouseOverRect(width/2, height/2+200, 75, 30)) { //GO BACK
      typing="";
      errorMessage=false;
      action=true;
    }
    if (action) {
      currScreen="myClassroom";
      errorMessage=false;
    }
  }
}

void keyPressed() {
  if (currScreen=="fillStudentInfo") {
    if (typing.length()<20) {
      typing+=key;
    }
  }
  if (currScreen.substring(0,8).equals("addGrade")) {
    if (currTextMode=="gradeV"){ //Digits 0-9 have ASCII code: 48-57
      if (gradeV.length()<3){
        if (key>=48 && key<=57){
          gradeV+=key;
        }
      }
    }else if(currTextMode=="title"){
      if (title.length()<11){
        title+=key;
      }
    }
  }
  if (key == BACKSPACE){
    if (currScreen=="fillStudentInfo"){
      if (typing.length()>0){
        typing=typing.substring(0,typing.length()-2);
      }  
    }else if (currTextMode=="title"){
      if (title.length()>0){
        title=title.substring(0,title.length()-2);
      }
    }else if (currTextMode=="gradeV"){
      if (gradeV.length()>0){
        gradeV=gradeV.substring(0,gradeV.length()-1);
      }
    }
  }
}


//===HELPFUL STUFF===//
boolean mouseOverCircle(float x, float y, float diameter) {
  return (dist(mouseX, mouseY, x, y) < diameter*0.5);
}

boolean mouseOverRect(float x, float y, float w, float h) {
  return (w/2>=Math.abs(x-mouseX) && h/2>=Math.abs(y-mouseY));
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
  }
}
