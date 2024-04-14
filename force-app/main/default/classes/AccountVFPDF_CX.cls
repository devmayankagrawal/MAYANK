public class AccountVFPDF_CX {
     Public  Account objAccount {get; set;}

    public AccountVFPDF_CX(ApexPages.StandardController controller) {
    
    string accountName = apexPages.CurrentPage().getParameters().get('AccountName');
    
    system.debug('#Account Name='+accountName);
    
    if(string.isNotBlank(accountName)){
    
            objAccount = [select id, Name, Type, Rating, SLA__c from Account where Name=: accountName Limit 1];
           }
           else{
           system.debug('Account Name should not be blank');
           }
    }

}