public class AccountToOpportunity_CX {
    
        public List<Account> accList {get;set;}
    
    public AccountToOpportunity_CX(ApexPages.StandardController controller) {
        
            string accId = ApexPages.currentPage().getParameters().get('AccountId');
            
            if(string.isNotBlank(accId)){
            accList = [select Id,Name,(select Id,Name,Amount,ExpectedRevenue,CloseDate,StageName from Opportunities) from Account where Id=:accId];
                system.debug('#Account Records='+accList);
        }
            else{
                system.debug('#Account Name should not be blank');
            }
   } 

}