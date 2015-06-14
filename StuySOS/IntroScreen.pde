void introScreen() {
  background(chalkboard);
  fill(255);
  textSize(48);
  PFont chalkFont;
  chalkFont = loadFont("Chalkduster-48.vlw");
  textFont(chalkFont);
  text("Welcome to StuySOS!", width/2, height/2);
  noStroke();
  fill(beginButton);
  rect(width/2, height/2+70, 100, 30, 10); //BEGIN
  fill(255);
  textSize(20);
  text("Begin", width/2, height/2+67);
  fill(loadButton);
  rect(width/2, height/2+120, 100, 30, 10); //LOAD
  fill(255);
  textSize(20);
  text("Load", width/2, height/2+120);

  if (mouseOverRect(width/2, height/2+70, 100, 30)) { //BEGIN
    //beginButton=color(158, 123, 255);
    beginButton=color(153, 51, 255);
  } else {
    beginButton=color(148, 114, 236);
  }
  
  if (mouseOverRect(width/2, height/2+120, 100, 30)) { //LOAD
    loadButton=color(158, 123, 255);
  } else {
    loadButton=color(148, 114, 236);
  }
}
