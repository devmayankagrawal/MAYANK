public class IncomeTax {

    @testVisible
    private static Decimal incomeTaxCall(Decimal Salary,Decimal Roi){
        return (Salary*Roi)/100;
    }
}