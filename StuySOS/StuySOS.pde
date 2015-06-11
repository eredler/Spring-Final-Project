Student[][] myStudents;
Button[][] myButtons; //same as students
private int numRows, numCols;

import java.util.*;
import java.lang.*;
import java.io.*;

PImage cursorImage;
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
String gradeType; //for addGrade screens
float currTextX, currTextY; //for the addGrade screens, where you have two input boxes to deal with


void setup() {
  size(1000, 750);
  //size(displayWidth,displayHeight); //COOL FEATURE: resizes to screen size of computer program is running on :D
  //check sketchFullScreen() method in processing wiki if automatically want to start full screen
  background(102, 178, 255);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  cursor(CROSS); //COOL FEATURE: not necessary, but looks like a cool target practice thing with the mouse :)
  cursorImage=loadImage("images/pencil-animated.gif");
  //cursor(cursorImage);

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

void loadInfo(){
  try {
    Scanner info = new Scanner(new File("studentInfo.txt"));
    while (info.hasNextLine ()) {
      String line = info.nextLine();
      System.out.println(line);
      String[] rowInfo = line.split("|"); //split rows
      for (int g = 0; g < rowInfo.length; g++) {
        String[] indivStudents = rowInfo[g].split(";"); // split individul students in form "name, latenesses, absences"
        for (int i = 0; i < indivStudents.length; i++) {
          String[] thisStudent = indivStudents[i].split(",");
          Student s = new Student(thisStudent[0]);
          s.setNumLate(Integer.parseInt(thisStudent[1]));
          s.setNumAbsent(Integer.parseInt(thisStudent[2]));
          myStudents[g][i] = s;
        }
      }
    }
  } catch (FileNotFoundException e) {
    PrintWriter output = createWriter("studentInfo.txt");
  }
}

/*
void save() {
  PrintWriter output;
  try {
  output = new PrintWriter(new BufferedWriter(new FileWriter(new File("studentInfo.txt"),true)));
  } catch (Exception e){
   output = createWriter("studentInfo.txt"); 
  }
  String thisRow = "";
  try{
  for (int i = 0; i < myStudents.length; i++){
    thisRow = myStudents[i][0].getName() + "," + myStudents[i][0].getNumLate() + "," + myStudents[i][0].getNumAbsent();
    for (int c = 1; c < myStudents[0].length; c++) {
      thisRow += ";" + myStudents[i][c].getName() + "," + myStudents[i][c].getNumLate() + "," + myStudents[i][c].getNumAbsent();
    }
    thisRow+="|";
  }
  output.println(thisRow);
  } catch (NullPointerException e){}
  catch (ArrayIndexOutOfBoundsException e){}
}
*/

void draw() {
  //maybe add a main welcome page or something later
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
  } else if (currScreen=="addGradeHW") {
    gradeType="hw";
    addGradeScreen("Homework");
  } else if (currScreen=="addGradeParticipation") {
    gradeType="participation";
    addGradeScreen("Participation");
  } else if (currScreen=="addGradeTest") {
    gradeType="test";
    addGradeScreen("Test");
  } else if (currScreen=="addGradeOther") {
    gradeType="other";
    addGradeScreen("Other");
  }
}

void mouseClicked() {
  //WELCOME Screen
  if (mouseOverRect(mainButtonX, mainButtonY+15, mainButtonWidth, mainButtonHeight) && currScreen!="introScreen") {
    //save();
    System.exit(0);
  } else if (currScreen=="introScreen") {
    if (mouseOverRect(width/2, height/2+92, 100, 30)) { //BEGIN
      currScreen="titleScreen1";
    } else {
      beginButton=color(148, 114, 236);
    }
    if (mouseOverRect(width/2,height/2+143,100,30)) { //LOAD
    currScreen="myClassroom";
 //   loadInfo();
    } else {
     loadButton=color(148,114,236); 
    }
  }
  //TITLESCREEN1 = pick number of rows
  else if (currScreen=="titleScreen1") {
    for (int i=1; i<=8; i++) {
      //if (25 >= Math.abs(widths.get(i-1) - mouseX) && 25 >= Math.abs(heights.get(i-1) - mouseY)) {
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
  } 
  //CLASSROOM Screen = shows all students currently enrolled in your class
  else if (currScreen=="myClassroom") {
    if (attendance == false && switchSeats==false) {
      if (mouseOverRect(mainButtonX+60, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
        attendance=true;
      } else if (mouseOverRect(mainButtonX+250, mainButtonY+50, mainButtonWidth+100, mainButtonHeight)) {
        switchSeats=true;
        numStudentsSwitched = 0;
      }
    }

    //TAKING ATTENDANCE
    if (attendance) {
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
    //IF JUST ENTERING NEW STUDENT OR LOOKING AT A CURRENT STUDENT'S INFO
    else if (!attendance && !switchSeats) {
      for (int r=0; r<numRows; r++) {
        for (int c=0; c<numCols; c++) {
          if (studentBoxWidths >= Math.abs(studentBoxX.get(numCols*(r)+c)-mouseX) && studentBoxHeights >= Math.abs(studentBoxY.get(numCols*(r)+c)-mouseY)) {
            //currScreen="fillStudentInfo";
            currStudentRow=r;
            currStudentCol=c;
            if (myStudents[currStudentRow][currStudentCol].getName().equals("")) {
              currScreen="fillStudentInfo";
              //  studentInfoMode="newStudent";
            } else {
              currScreen="studentInfo";
              //  studentInfoMode="currentStudent";
            }
          }
        }
      }
    }
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

  //STUDENT INFORMATION Screen = looking at/editing a selected student's information 
  else if (currScreen=="studentInfo") {
    if (mouseOverRect(width/2, height/2+100, 75, 30)) { //EDIT INFO
      currScreen = "fillStudentInfo";
    }
    if (mouseOverRect(mainButtonX, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
      currScreen="myClassroom";
    } else if (mouseOverRect(width/2, height/2+150, 150, 30)) { //add homework
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
    //if (mouseOverRect(width/2, height/2+100, 75, 30)) { //SUBMIT
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
      //currScreen="myClassroom";
      action=true;
    }
    if (action) {
      currScreen="myClassroom"; //maybe next step of studentInfo?
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
  if (key == BACKSPACE) {
    typing = typing.substring(0, typing.length()-2);
  }
  /* if (currScreen=="addGrade") {
   if (title.length()<23) {
   if (key >= 96 && key <= 105) {
   gradeV+=key;
   } else {
   title+=key;
   }
   }
   }*/
}


//===HELPFUL STUFF===//
boolean mouseOverCircle(float x, float y, float diameter) {
  return (dist(mouseX, mouseY, x, y) < diameter*0.5);
}

boolean mouseOverRect(float x, float y, float w, float h) {
  //return (mouseX >= x-(w/2) && mouseX <= x+(w/2) && mouseY >= y-(h/2) && mouseY <= y+(h/2));
  return (w/2>=Math.abs(x-mouseX) && h/2>=Math.abs(y-mouseY));
}

void mainButton() {
  noStroke();
  textSize(18);
  fill(mainButtonColor);
  rect(mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight, 12);
  fill(255, 255, 255);
  text("Exit", mainButtonX, mainButtonY);

  if (mouseOverRect(mainButtonX, mainButtonY+15, mainButtonWidth, mainButtonHeight)) {
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
/*
void currStudentLocation(boolean screenChange, String newScreen){
 for (int r=0; r<numRows; r++) {
 for (int c=0; c<numCols; c++) {
 if (studentBoxWidths >= Math.abs(studentBoxX.get(numCols*(r)+c)-mouseX) && studentBoxHeights >= Math.abs(studentBoxY.get(numCols*(r)+c)-mouseY)) {
 if (screenChange){
 currScreen=newScreen;  
 }
 currStudentRow=r;
 currStudentCol=c;
 }
 }
 }
 */
