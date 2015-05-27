public class Student {
  
  private String name;  
  private int numLate;
  private int numAbsent;
  private ArrayList<grade> gradeList;
  private int row;
  private int seat;
  public void setName(String n){
      name = n; 
   }
 
   private void setNumLate(int n){
      numLate = n; 
   }
     
   private void setNumAbsent(int n){
      numAbsent = n; 
   }
   
   private void addGrade(String type, String name, int scoreEarned, int scoreTotal){
      gradeList.add(new Grade(type,name,scoreEarned,scoreTotal));
   }
   
   private void addGrade(String type, String name, int scoreEarned){
      gradeList.add(new Grade(type,name,scoreEarned));
   }
    
}

