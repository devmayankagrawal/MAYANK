@isTest
public class TestTataCar {

    @isTest
    public static void testAdditionMethod(){
        integer result = TataCar.addition(10,20);
        system.assertEquals(30, result);
    }
    
    @isTest
    public static void testMultiplicationMethod(){
        integer result = TataCar.multiplication(10,20);
        system.assertEquals(200, result);
    }
}