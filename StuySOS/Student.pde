public class Student {
  
  private String name;  
  private int numLate;
  private int numAbsent;
  private ArrayList<Grade> gradeList;
  private int row;
  private int seat;
  int numClicks;
  boolean switchMe;
  
  public Student(String name){
    this.name=name;
    numLate=0;
    numAbsent=0;
    gradeList=new ArrayList<Grade>();
    //set row and seats? 
  }
  public Student(){
    name="";
    numLate=0;
    numAbsent=0;
    gradeList=new ArrayList<Grade>();
  } 
  
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
   
   private void addGrade(String type, String name, int scoreEarned, int scoreTotal){
      gradeList.add(new Grade(type,name,scoreEarned,scoreTotal));
   }
   
   private void addGrade(String type, String name, int scoreEarned){
      gradeList.add(new Grade(type,name,scoreEarned));
   }
   
   private ArrayList<Grade> getGrades(){
      return gradeList; 
   }
   
   private double getGPA(){
     double sumEarned=0;
     double sumTotal=0;
     for (int i=0;i<gradeList.size();i++){
       sumEarned+=(double)gradeList.get(i).getScoreEarned();
       sumTotal+=(double)gradeList.get(i).getScoreTotal();
     }
     return sumEarned/sumTotal*100;
   }
    
}

