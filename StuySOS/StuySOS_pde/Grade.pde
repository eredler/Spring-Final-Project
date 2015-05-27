public class Grade {
  
  private String type;
  private int scoreEarned;
  private int scoreTotal;
  private String name;
  
  public grade(String t, String n, int se. int st){
      setType(t);
      setName(n);
      setScoreEarned(se);
      setScoreTotal(st);  
  }
  
  public grade(String t, String n, int se){
      setType(t);
      setName(n);
      setScoreEarned(se);
      setScoreTotal(100);  
  }
  
  public void setType(String t){
     type = t; 
  }
  
  public void setScoreEarned(int v){
     scoreEarned = v; 
  }
  
  public void setScoreTotal(int v){
     scoreTotal = v; 
  }
  
  public void setName(String n){
     name = n; 
  }
  
  public String getType(){
     return type;
  }
  
  public int getScoreEarned(){
     return scoreEarned; 
  }
  
  public int getScoreTotal(){
     return scoreTotal; 
  }
  
  public String getName(String n){
     return name; 
  }
  
  public String toString(){
     return getType() + " " + getName() + ": " + getScoreEarned() + " out of " + getScoreTotal();  
  }
  
}
