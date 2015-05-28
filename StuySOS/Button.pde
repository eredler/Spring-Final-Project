public class Button{ //Should I make it abstract?
  int buttonX,buttonY; //x and y coordinates of the button
  String function; //IDK about this
  color myMainColor, highlightColor; //color is normal color of button; highlightColor is temporary color button changes to when hovered over
  color currColor;
  
  //public Button
  
  public void isMouseOverMe(){
     if (Math.abs(mouseX-buttonX)<5 && Math.abs(mouseX-buttonY)<5){
        currColor=highlightColor;       
     }else{
        currColor=myMainColor; 
     }
  }
  
}
