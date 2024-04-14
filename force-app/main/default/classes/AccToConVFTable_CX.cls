public class AccToConVFTable_CX {
        
        public  List<Account> accList  {get;set;}
        
    public AccToConVFTable_CX(ApexPages.StandardController controller) {
    
            string accId = ApexPages.currentPage().getParameters().get('AccountId');
    
         accList = [select Id,Name,(select Id,FirstName,LastName from Contacts) from Account where Id=: accId];
        system.debug('#Account Records='+accList );

    }

}