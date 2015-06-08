void classroomScreen() {
  background(0, 102, 0);
  studentBoxHeights=(height-50)/(numRows+5);
  studentBoxWidths=(width-50)/(numCols+5);
  for (int r=0; r<numRows; r++) {
    for (int c=0; c<numCols; c++) {
      String studentName="";
      if (myStudents[r][c]==null) {
        myStudents[r][c]=new Student();
        studentName=myStudents[r][c].getName();
      } else if (!myStudents[r][c].getName().equals("")) {
        studentName=myStudents[r][c].getName();
      }
      float x= (width*(c+1)/(numCols+1));
      float y= (height*(r+1)/(numRows+1));
      studentBoxX.add(x);
      studentBoxY.add(y);
      stroke(0, 102, 204);
      fill(0, 75);
      //rect((width*(c+1)/(numCols+1)), (height*(r+1)/(numRows+1)), studentBoxWidths, studentBoxHeights, 10);
      rect(x, y, studentBoxWidths, studentBoxHeights, 10);
      noStroke();
      fill(255);
      if (numRows*numCols <=15) {
        textSize(24);
      } else {
        textSize(16);
      }
      //text(studentName, width*(c+1)/(numCols+1), height*(r+1)/(numRows+1));
      text(studentName, x, y);
      if (attendance){
        if (myStudents[r][c].numClicks%3==0){
       //  text("present",x,y+20);
        } else if (myStudents[r][c].numClicks%3==1){
          text("late",x,y+20); 
        } else {
           text("absent",x,y+20); 
        }
      }
      if (switchSeats){
        if (myStudents[r][c].switchMe == true){
         text("ME",x,y+20);
        } 
      }
    }
  }
  
  fill(AttButtonColor);
  rect(mainButtonX+60, mainButtonY+50, mainButtonWidth+120, mainButtonHeight, 12); //attendance button
  fill(switchColor);
  rect(mainButtonX+250, mainButtonY+50, mainButtonWidth+80, mainButtonHeight, 12); //switch seats button
  fill(255);
  text("Take Attendance",mainButtonX+60, mainButtonY+50);
  text("Switch Seats",mainButtonX+250,mainButtonY+50);
  if (attendance || switchSeats){
    fill(AttSubButtonColor);
    rect(mainButtonX, mainButtonY+100, mainButtonWidth, mainButtonHeight, 12); //submit attendance
    fill(255);
    text("Submit",mainButtonX, mainButtonY+100);
  }
  
  mainButton();
}
