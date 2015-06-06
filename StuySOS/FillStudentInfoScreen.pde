void studentInfoScreen(int currR, int currC) {
  background(102, 158, 242);
  
  stroke(0);
  fill(255);
  rect(width/2,height/2,150,35,10); //textbox
  fill(125,125,125);
  rect(width/2,height/2+100,75,30,10); //Submit button
  noStroke();
  
  int studentNum=numCols*(currR)+currC+1;
  textSize(24);
  fill(0);
  String s = "Please input info for student " + studentNum + ".";
  text(s, width/2, height/3);
  textSize(16);
  text("Name: ",width/2-100,height/2);
  text(typing, width/2, height/2);
  text("Submit",width/2,height/2+100);
  
  mainButton(); //remove later; only for testing and debuggin purposes
  
}


//HELP FROM: http://www.learningprocessing.com/examples/chapter-18/example-18-1/
String typing = "";// Variable to store text currently being typed

void keyPressed(){
  if (currScreen=="fillStudentInfo"){
      typing+=key;
  } 
}
