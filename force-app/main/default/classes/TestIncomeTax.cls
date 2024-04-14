@isTest
public class TestIncomeTax {

    public static testMethod void incomeCallTestMethod(){
        decimal incomeTaxResult = IncomeTax.incomeTaxCall(50000,7);
        system.assertEquals(3500, incomeTaxResult);
    }
}