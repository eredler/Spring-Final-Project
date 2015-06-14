String title=""; //name of grade type
String gradeV=""; //value of grade
String currTextMode="";

void addGradeScreen(String type) { //type = HW,PARTICIPATION,TEST,OTHER
  background(0, 102, 0);
  fill(255);
  text("Click on the box you want to type in.\nThen type a grade value (<=100) or name in the respective box",width/2,height/2-100);
  
  stroke(0);
  fill(255);
  rect(width/2, height/2, 150, 35, 10); //Grade textbox
  rect(width/2, height/2+50, 150, 35, 10); //Grade type (name of assignment/test) textbox
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
  text(gradeV, width/2, height/2);
  text(title, width/2, height/2+50);
  fill(255);
  text("Submit", width/2, height/2+100);

  text("Clear", width/2, height/2+150);
  text("Go Back", width/2, height/2+200);  

  if (mouseOverRect(width/2, height/2+100, 75, 30)) {
    submitButtonColor=color(30, 205, 151);
    submitTextColor=color(255, 255, 255);
  } 
  
}
