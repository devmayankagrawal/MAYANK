public class AccVF_CX {
        
        public Account objAcc {get; set;}
        
        public AccVF_CX(ApexPages.StandardController controller) {
        
        string accountName =  ApexPages.currentPage().getParameters().get('AccountName');
         string accountType =  ApexPages.currentPage().getParameters().get('Type');
        
                if(string.isNotBlank(accountName)){
                
                objAcc = [select Id,Name,Type,SLA__c from Account where Name=: accountName and Type=:accountType];
                
                }
                else{
                system.debug('#Account Name hould not be blank');
                }
             }
        
        }