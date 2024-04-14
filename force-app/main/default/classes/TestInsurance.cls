@isTest
public class TestInsurance {

    @isTest
    public static void testPrefixMrMethod(){
        string resultName = new Insurance().prefixName('Bunty','Male');
        system.assertEquals('Mr.Bunty',resultName);
    }
    
     @isTest
    public static void testPrefixMsMethod(){
        string resultName = new Insurance().prefixName('Bubli','Female');
        system.assertEquals('Ms.Bubli',resultName);
    }
    
}