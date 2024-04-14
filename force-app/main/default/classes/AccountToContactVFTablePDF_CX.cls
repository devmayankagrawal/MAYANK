public class AccountToContactVFTablePDF_CX {
       PUblic List<Account> accList {get; set;}

    public AccountToContactVFTablePDF_CX(ApexPages.StandardController controller) {
    
    string accID = apexPages.CurrentPage().getparameters().get('AccountID');
    
     accList = [select Name, ID, Type, Rating, (select FirstName, LastName, ID, Department, Level__c from Contacts) from Account where ID=: accID];

    }

}