public class Student {
  
  private String name;  
  private int numLate;
  private int numAbsent;
  private ArrayList<Grade> gradeList;
  private int row;
  private int seat;
  
  public void setName(String n){
      name = n; 
   }
 
   public String getName(){
      return name; 
   }
   
   private void setNumLate(int n){
      numLate = n; 
   }
     
   private void setNumAbsent(int n){
      numAbsent = n; 
   }
   
   public int getNumLate(){
      return numLate; 
   }
   
   public int getNumAbsent(){
      return numAbsent; 
   }
   
   public void setRow(int r){
       row = r;
   }  
   
   public void setSeat(int s){
      seat = s; 
   }
   
   public int getRow(){
      return row; 
   }
   
   public int getSeat(){
      return seat; 
   }
   
   public void setSpot(int r, int s){
     setRow(r);
     setSeat(s);
   }
   
   public void switchSeats(Student other){
      int s = this.getSeat();
      int r = this.getRow();
      this.setSpot(other.getRow(),other.getSeat());
      other.setSpot(r,s); 
   }
   
   private void addGrade(String type, String name, int scoreEarned, int scoreTotal){
      gradeList.add(new Grade(type,name,scoreEarned,scoreTotal));
   }
   
   private void addGrade(String type, String name, int scoreEarned){
      gradeList.add(new Grade(type,name,scoreEarned));
   }
    
}

