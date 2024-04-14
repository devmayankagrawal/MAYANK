public class child extends Parent{
    
    public void display(){
        // System.debug('X='+x);  Can not access, because of private
        System.debug('y='+y);
        System.debug('Z='+z);
        System.debug('P='+p);
        
    }
    
    
    
}