void addGradeScreen(String type) { //type = HW,PARTICIPATION,TEST,OTHER
  background(0, 102, 0);

  stroke(0);
  fill(255);
  rect(width/2, height/2, 150, 35, 10); //textbox
  rect(width/2, height/2+50, 150, 35, 10); //textbox
  stroke(30, 205, 151);
  fill(submitButtonColor);
  rect(width/2, height/2+100, 75, 30, 20); //Submit button
  fill(30, 205, 151);
  rect(width/2, height/2+150, 75, 30, 20); //Clear button
  rect(width/2, height/2+200, 100, 30, 20); //Go Back button
  noStroke();

  textSize(24);
  fill(255);
  textSize(16);
  text("Grade (out of 100): ", width/2-175, height/2);
  text(type + " name: ", width/2-175, height/2+50);
  fill(0);
 // text(gradeV, width/2, height/2);
 // text(title, width/2, height/2+50);
  fill(255);
  text("Submit", width/2, height/2+100);

  text("Clear", width/2, height/2+150);
  text("Go Back", width/2, height/2+200);

  

  if (mouseOverRect(width/2, height/2+100, 75, 30)) {
    submitButtonColor=color(30, 205, 151);
    submitTextColor=color(255, 255, 255);
  } 



  String title="";
  String gradeV="";
}
/*
void keyReleased() {
  if (currScreen=="addGrade") {
    if (title.length()<23) {
      if (key >= 96 && key <= 105) {
        gradeV+=key;
      } else {
        title+=key;
      }
    }
  }
  
  if (key == BACKSPACE) {
    title = title.substring(0, title.length()-2);
  }
}*/

