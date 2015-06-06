color submitButtonColor, submitTextColor; //initialized in setup
boolean errorMessage;

void studentInfoScreen(int currR, int currC) {
  background(102, 158, 242);
  //textCheck();
  
  stroke(0);
  fill(255);
  rect(width/2, height/2, 150, 35, 10); //textbox
  stroke(30, 205, 151);
  fill(submitButtonColor);
  rect(width/2, height/2+100, 75, 30, 20); //Submit button
  fill(30, 205, 151);
  rect(width/2, height/2+150, 75, 30, 20); //Clear button
  rect(width/2, height/2+200, 75, 30, 20); //Go Back button
  noStroke();

  int studentNum=numCols*(currR)+currC+1;
  textSize(24);
  fill(0);
  String s = "Please input info for student " + studentNum + ".";
  text(s, width/2, height/3);
  textSize(16);
  text("Name: ", width/2-100, height/2);
  text(typing, width/2, height/2);
  fill(submitTextColor);
  text("Submit", width/2, height/2+100);
  fill(0);
  text("Clear", width/2, height/2+150);
  text("Go Back", width/2, height/2+200);
  
  if(errorMessage){
    printErrorMessage("ERROR: Please enter a name.",width/2,height*5/12,color(255,0,0));
  }
  
  if (myStudents[currStudentRow][currStudentCol].getName().equals("")) {
    mainButton(); //remove later; only for testing and debuggin purposes
  }
  if (mouseOverRect(width/2, height/2+100, 75, 30)) {
    submitButtonColor=color(30, 205, 151);
    submitTextColor=color(255, 255, 255);
  } else {
    submitButtonColor=color(255, 255, 255, 25);
    submitTextColor=color(30, 205, 151);
  }
}

void loadStudentInfo(int currR, int currC) {
  background(0);
  
  fill(255);
  textSize(18);
  text("Student Information",width/2,30);
  
  textAlign(LEFT,CENTER);
  textSize(14);
  text(myStudents[currR][currC].getName()+"'s Info:", 50 ,100);
  textAlign(CENTER,CENTER);
  
  mainButton();
}

//HELP FROM: http://www.learningprocessing.com/examples/chapter-18/example-18-1/
String typing = "";// Variable to store text currently being typed
//void textCheck(){
//  if (myStudents[currStudentRow][currStudentCol] != null){
//    typing=myStudents[currStudentRow][currStudentCol].getName();
//  }
//}

void keyPressed() {
  if (currScreen=="fillStudentInfo") {
    if (typing.length()<12) {
      typing+=key;
    }
    if (key == BACKSPACE) {
      typing = typing.substring(0, typing.length()-2);
    }
  }
}

void printErrorMessage(String message, int x, int y, color c){
  fill(c);
  text(message,x,y);  
}
