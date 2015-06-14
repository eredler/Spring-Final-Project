void studentInfoScreen(int currR, int currC, Student[][] myStudents) {
  background(0, 102, 0);
  mainButton();
  fill(backColor);
  rect(mainButtonX,mainButtonY+50,mainButtonWidth,mainButtonHeight,12);
  fill(255);
  text("Back",mainButtonX,mainButtonY+50);
  
  Student s = myStudents[currR][currC];
  String name = s.getName();
  String numLate = "Latenesses: " + s.getNumLate();
  String numAbs = "Absences: " + s.getNumAbsent();

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
  }
  if (s.getGPA()>=0.0){
      text("GPA: "+s.getGPA()+" %",width/2,height/3+100);
    }
  
  
  
  stroke(30, 205, 151);
  fill(0);
  rect(width/2,height/2+50, 150, 30, 20); //edit info button
  rect(width/2,height/2+100, 150, 30, 20); //View Grades button
  rect(width/2,height/2+150,200,30,20); // add homework
  rect(width/2,height/2+200,150,30,20); // add test
  rect(width/2,height/2+250,310,30,20); // add participation grade
  rect(width/2,height/2+300,220,30,20); // add other grade
  
  fill(255);
  text("Edit Info", width/2, height/2+50);
  text("View Grades", width/2, height/2+100);
  text("Add Homework", width/2, height/2+150);
  text("Add Test", width/2, height/2+200);
  text("Add Participation Grade", width/2, height/2+250);
  text("Add Other Grade", width/2, height/2+300);
  
  
  if (mouseOverRect(mainButtonX, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
    backColor=color(153, 51, 255);
  }else {
    backColor=color(178, 102, 255);
  }

}
