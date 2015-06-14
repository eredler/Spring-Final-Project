color submitButtonColor, submitTextColor, goBackColor, goBackTextColor, clearColor, clearTextColor;
boolean errorMessage;
String typing = "";// Variable to store text currently being typed

void fillStudentInfoScreen(int currR, int currC) {
  background(0, 102, 0);

  stroke(0);
  fill(255);
  rect(width/2, height/2, 200, 35, 10); //textbox
  stroke(30, 205, 151);
  fill(submitButtonColor);
  rect(width/2, height/2+100, 75, 30, 20); //Submit button
  fill(30, 205, 151);
  rect(width/2, height/2+150, 75, 30, 20); //Clear button
  rect(width/2, height/2+200, 100, 30, 20); //Go Back button
  noStroke();

  int studentNum=numCols*(currR)+currC+1;
  textSize(24);
  fill(255);
  String s = "Please input info for student in seat " + studentNum + ".";
  text(s, width/2, height/3);
  textSize(16);
  text("Name: ", width/2-150, height/2);
  fill(0);
  text(typing, width/2, height/2);
  fill(255);
  text("Submit", width/2, height/2+100);

  text("Clear", width/2, height/2+150);
  text("Go Back", width/2, height/2+200);

  if (errorMessage) {
    printErrorMessage("ERROR: Please enter a name.", width/2, height*5/12, color(255, 0, 0));
  }

  if (myStudents[currStudentRow][currStudentCol].getName().equals("")) {
    mainButton(); //DO NOT DELETE -- CONTAINS MOUSEOVER BUTTON COLOR CHANGING FUNCTIONALITY
  }
  if (mouseOverRect(width/2, height/2+100, 75, 30)) {
    submitButtonColor=color(30, 205, 151);
    submitTextColor=color(255, 255, 255);
  } else {
    submitButtonColor=color(255, 255, 255, 25);
    submitTextColor=color(30, 205, 151);
  }
  if (mouseOverRect(width/2, height/2+150, 75, 30)) {
    clearColor=color(30, 205, 151);
    clearTextColor=color(255, 255, 255);
  } else {
    clearColor=color(255, 255, 255, 25);
    clearTextColor=color(30, 205, 151);
  }
  if (mouseOverRect(width/2, height/2+200, 75, 30)) {
    goBackColor=color(30, 205, 151);
    goBackTextColor=color(255, 255, 255);
  } else {
    goBackColor=color(255, 255, 255, 25);
    goBackTextColor=color(30, 205, 151);
  }
}

void loadStudentInfo(int currR, int currC) {
  background(0);
  
  fill(255);
  textSize(40);
  text("Student Information",width/2,30);
  textSize(16);
  rect(width*3/4, 250, 150, 30, 20); //Return to Classroom button
  fill(0);
  text("Return to Classroom", width*3/4, 200);
  
  textAlign(LEFT,CENTER);
  fill(255);
  textSize(18);
  text(myStudents[currR][currC].getName()+"'s Info:", 50 ,100);
  textAlign(CENTER,CENTER);
  
  mainButton();
}

void printErrorMessage(String message, int x, int y, color c) {
  fill(c);
  text(message, x, y);
}

