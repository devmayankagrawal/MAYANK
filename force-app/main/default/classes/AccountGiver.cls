public with sharing class AccountGiver {
   
    @AuraEnabled
    public static string createAccountRecord(Account objAcc){
        try {
            if(objAcc != null){
                insert objAcc;
                return 'Account Record Created successfully';

            }
            else{

                return null;
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Contact> searchAccountContacts(Account objAcc){
        try {
            if(objAcc != null){
                Id accId15 = [select Id from Account where Name=: objAcc.Name].id;
                return([select Id,FirstName,LastName,LeadSource,Level__c from Contact where AccountId =: accId15]);
            }
            else{

                return null;
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}