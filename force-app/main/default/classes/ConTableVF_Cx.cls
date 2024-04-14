public class ConTableVF_Cx {

            public  List<Contact> conList {get; set;}
    
    public ConTableVF_Cx(ApexPages.StandardController controller) {
    
            string accName = ApexPages.currentPage().getParameters().get('AccountName');
            
            if(string.isNotBlank(accName)){
                conList = [select Id,FirstName,LastName,Department,Level__c,Account.Name from Contact where Account.Name=: accName];
                system.debug('#Contact List='+conList);
            }
                else{
                    system.debug('#Account Id should not be blank');
                }

    }

}