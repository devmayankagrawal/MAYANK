public class OppTableVF_CX {

            public  List<Opportunity> oppList {get;set;}

    public OppTableVF_CX(ApexPages.StandardController controller) {
    
            string accName = ApexPages.currentPage().getParameters().get('AccountName');
            
            if(string.isNotBlank(accName)){
                 oppList = [select Id,Name,Amount,ExpectedRevenue,CloseDate,StageName,Account.Name from opportunity where Amount>=10000 and Account.Name=: accName];
                system.debug('#Opportunity List='+oppList);
            }
                else{
                        system.debug('#Account name cannot be blank');
                }

    }

}