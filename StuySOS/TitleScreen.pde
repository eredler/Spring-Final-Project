void titleScreen() {
  background(chalkboard);
  textSize(24);
  stroke(255, 255, 255);
  String message="Something is not working if this appears";
  if (currScreen=="titleScreen1") {
    message="How many rows of students are there?";
  } else if (currScreen=="titleScreen2") {
    message="How many seats per row?";
  }
  text(message, width/2, height/2-10);
  textSize(16);
  fill(buttonNotClicked);
  stroke(buttonNotClicked);
  for (int i=1; i<=8; i++) {
    float x=width*i/9;
    //float h=height/2 + (30*((i+3)/4));
    float y=height/2+50;
    widths.add(x);//+25);
    heights.add(y);//+23);
    rect(x, y, 50, 50, 10);
    //rect(width/2 + (30*((i%4)-2.5)) - 10,height/2 + (30*((i+3)/4)) -10,20,20,10);
  }
  for (int i=1; i<=8; i++) {
    fill(255, 255, 255);
    //text(""+i,width/2 + (30*(((i-1)%4)-2.5)), height/2 + (30*((i+3)/4)) );
    text(""+i, widths.get(i-1), heights.get(i-1));
  }
  noStroke();
  textSize(18);
  mainButton();
}
