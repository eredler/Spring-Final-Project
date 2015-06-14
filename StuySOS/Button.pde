public class Button{
  float buttonX,buttonY; //x and y coordinates of the button
  float buttonWidth,buttonHeight;
  String name; //IDK about this
  String currScreen,nextScreen; //currScreen is the screen the button can be found on; nextScreen is the screen the button links to when clicked on
  color myMainColor, highlightColor; //color is normal color of button; highlightColor is temporary color button changes to when hovered over
  color currColor;
  int radius; //radius of the corners of the rectangles
  
  //CONSTRUCTORS
  public Button(float buttonX, float buttonY, float buttonWidth, float buttonHeight, String name, String currScreen, String nextScreen, color myMainColor, color highlightColor){
    setX(buttonX);
    setY(buttonY);
    setWidth(buttonWidth);
    setHeight(buttonHeight);
    setName(name);
    setCurrScreen(currScreen);
    setNextScreen(nextScreen);
    setMainColor(myMainColor);
    setHighlightColor(highlightColor);
    setRadius(10);
    currColor=myMainColor;
  }
  
  public Button(float buttonX, float buttonY, float buttonWidth, float buttonHeight, String currScreen, String nextScreen){
    setX(buttonX);
    setY(buttonY);
    setWidth(buttonWidth);
    setHeight(buttonHeight);
    setName("EMPTY"); //change to "" later; for now, "EMPTY" used for debugging purposes
    setCurrScreen(currScreen);
    setNextScreen(nextScreen);
    setRadius(10);
    currColor=myMainColor;
  }
  
  public Button(float buttonX, float buttonY, float buttonWidth, float buttonHeight){
    setX(buttonX);
    setY(buttonY);
    setWidth(buttonWidth);
    setHeight(buttonHeight);
    setName("EMPTY"); //change to "" later; for now, "EMPTY" used for debugging purposes
    setCurrScreen("");
    setNextScreen("");
    setRadius(10); 
    currColor=myMainColor;   
  }
  
  //LEGIT NECESSARY/HELPFUL METHODS
  public void drawButton(){
    fill(currColor);
    rect(buttonX,buttonY,buttonWidth,buttonHeight,radius);
    fill(255);
    text(name,buttonX,buttonY);
  }
  
  public void isMouseOverMe(){
     //if (Math.abs(mouseX-buttonX)<5 && Math.abs(mouseX-buttonY)<5){
     if (mouseOverRect(buttonX,buttonY,buttonWidth,buttonHeight)){
        currColor=highlightColor;       
     }else{
        currColor=myMainColor; 
     }
  }
  
  //ACCESSOR & MUTATOR METHODS
  public float getX(){
    return buttonX;
  }
  
  public void setX(float buttonX){
    this.buttonX=buttonX;
  }
  
  public float getY(){
    return buttonY;
  }
  
  public void setY(float buttonY){
    this.buttonY=buttonY;
  }

  public float getWidth(){
    return buttonWidth;
  }
  
  public void setWidth(float buttonWidth){
    this.buttonWidth=buttonWidth;
  }
  
  public float getHeight(){
    return buttonHeight;
  }
  
  public void setHeight(float buttonHeight){
    this.buttonHeight=buttonHeight;
  }
  
  public String getName(){
    return name; 
  }
  
  public void setName(String name){
    this.name=name; 
  }
  
  public String getCurrScreen(){
    return currScreen;
  }
  
  public void setCurrScreen(String currScreen){
    this.currScreen=currScreen;
  }
  
  public String getNextScreen(){
    return nextScreen;
  }
  
  public void setNextScreen(String nextScreen){
    this.nextScreen=nextScreen;
  }
  
  public color getMainColor(){
    return myMainColor;
  }
  
  public void setMainColor(color myMainColor){
    this.myMainColor=myMainColor;
  }
  
  public color getHighlightColor(){
    return highlightColor;
  }
  
  public void setHighlightColor(color highlightColor){
    this.highlightColor=highlightColor;
  }
  
  public int getRadius(){
    return radius; 
  }
  
  public void setRadius(int radius){
    this.radius=radius;  
  }
  
}
