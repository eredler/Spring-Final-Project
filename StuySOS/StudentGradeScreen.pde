void studentGradeScreen() {
  background(0, 102, 0);
  mainButton();
  fill(backColor);
  rect(mainButtonX,mainButtonY+50,mainButtonWidth,mainButtonHeight,12); //BACK button
  fill(255);
  text("Back",mainButtonX,mainButtonY+50);
  
  Student s = myStudents[currStudentRow][currStudentCol];
  String name = s.getName();
  ArrayList<Grade> grades = s.getGrades();
  if (name != ""){
    textSize(30);
    text(name, width/2, height/3-50);
    textSize(20);
  } else {
    text("Seat " + ((currStudentRow*numCols+currStudentCol)+1), width/2, height/3);
  }
  
  textSize(24);
  text("TYPE",width/5,height/3+30);
  text("NAME",width*2/5,height/3+30);
  text("SCORE EARNED",width*3/5,height/3+30);
  text("MAX POINTS",width*4/5,height/3+30);
  textSize(20);
        
  if (name!= ""){
    if (grades.size() > 0){
      for (int i=0;i<grades.size();i++){
        float h=height/3+70+(i*50);
        text(grades.get(i).getType(),width/5,h);
        text(grades.get(i).getName(),width*2/5,h);
        text(grades.get(i).getScoreEarned(),width*3/5,h);
        text(grades.get(i).getScoreTotal(),width*4/5,h);
      }
    }
    if (s.getGPA()>=0.0){
      textSize(24);
      text("GPA: "+s.getGPA()+" %",width/2,height/3-100);
      textSize(20);
    }
  }
  
  if (mouseOverRect(mainButtonX, mainButtonY+50, mainButtonWidth+120, mainButtonHeight)) {
    backColor=color(153, 51, 255);
  }else {
    backColor=color(178, 102, 255);
  }

}
