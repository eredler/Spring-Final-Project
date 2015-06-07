void classroomScreen() {
  background(0, 102, 0);
  studentBoxHeights=(height-50)/(numRows+5);
  studentBoxWidths=(width-50)/(numCols+5);
  for (int r=0; r<numRows; r++) {
    for (int c=0; c<numCols; c++) {
      String studentName="EMPTY";
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
    }
  }
  mainButton();
  fill(AttButtonColor);
  rect(mainButtonX+60, mainButtonY+50, mainButtonWidth+120, mainButtonHeight, 12);
  fill(255);
  text("Take Attendance",mainButtonX+60, mainButtonY+50);
}
