public class A2 {

      Integer x=100;  //Class Variable
    
    public void addition(Integer x){  //Local Variable
       this.x=this.x+x;
       System.debug('Local='+x+ 'Class Variable='+this.x);
    }  
    

}