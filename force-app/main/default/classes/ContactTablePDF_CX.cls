public class ContactTablePDF_CX {
     public List<Contact> conList {get; set;}

    public ContactTablePDF_CX(ApexPages.StandardController controller) {
    string accName= ApexPages.CurrentPage().getParameters().get('AccountName');
    if(string.isNotBlank(accName)){
    
    conList = [select ID, FirstName, LastName, Department, Level__c, Account.Name from Contact where Account.Name=: accName];
    system.debug('#Contact List='+conList);
       }

    }

}