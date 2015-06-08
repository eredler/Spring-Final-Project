void studentInfoScreen(int currR, int currC, Student[][] myStudents) {
  background(0, 102, 0);
  //textCheck();
  mainButton();
  fill(backColor);
  rect(mainButtonX,mainButtonY+50,mainButtonWidth,mainButtonHeight,12);
  fill(255);
  text("Back",mainButtonX,mainButtonY+50);
  
  Student s = myStudents[currR][currC];
  String name = s.getName();
  String numLate = "Latenesses: " + s.getNumLate();
  String numAbs = "Absences: " + s.getNumAbsent();
  String grades = s.getGrades();
  if (name != ""){
    textSize(30);
    text(name, width/2, height/3);
    textSize(20);
  } else {
    text("Seat " + ((currR*numCols+currC)+1), width/2, height/3);
  }
  if (name!= ""){
    text(numLate, width/2, height/3+50);
    text(numAbs, width/2, height/3+70);
    if (grades.length() > 0){
    //  text(grades, width/2, height/3+100);
    }
  }
  
  
  stroke(30, 205, 151);
  fill(0);
  rect(width/2, height/2+100, 150, 30, 20); //edit info button
 /* rect(width/2,height/2+150,150,30,20); // add homework
  rect(width/2,height/2+200,150,30,20); // add test
  rect(width/2,height/2+250,150,30,20); // add participation grade
  rect(width/2,height/2+300,150,30,20); // add other grade
  */
  fill(255);
  text("Edit Info", width/2, height/2+100);
 /* text("Add Homework", width/2, height/2+150);
  text("Add Test", width/2, height/2+200);
  text("Add Participation Grade", width/2, height/2+250);
  text("Add Other Grade", width/2, height/2+300);
  */
  
}
