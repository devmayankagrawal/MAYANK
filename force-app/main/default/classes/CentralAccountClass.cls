public with sharing class CentralAccountClass {
   
    @AuraEnabled
    public static void createAccountRecord(Account objAcc){
        try {
            insert objAcc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string createAccount(Account objAcc){
        try {
            insert objAcc;
            return 'Record Created Successfully';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Account searchAccountRecord(Account objAcc){
        system.debug('#Account Searched '+objAcc);
        try {
            if(objAcc != null){
           return   ([select Id,Name,Type,Rating,SLA__c from Account where Name = : objAcc.Name WITH SECURITY_ENFORCED]);
            }
            else{
                    return null;
            }

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string updateAccountRecord(Account objAcc){
        try {
            if(objAcc != null){
                Database.update(objAcc,false);
                return 'Record Updated Successfully';
            }
            else{
                return 'locha..Your Record is not Updated';
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string deleteAccountRecord(Account objAcc){
        try {
           if(objAcc != null){
            delete objAcc;
            return 'Your Record has been Sucessfully Deleted';
           }
           else{
                return 'Lochaaa..!!Something went wrong';
           }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static string undeleteAccountRecord(Account objAcc){
        try {
            Account objAccUndeleted = [select Id,Name,Rating,Type,SLA__c from Account where Name =: objAcc.Name and isDeleted=true LIMIT 1 ALL ROWS];
            system.debug('#Record found in Recylclebin '+objAccUndeleted);
            undelete objAccUndeleted;

            return 'Your Account Record Undeleted Successfully';
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Account> getAllAccountsType(String accType){
        try {
            if(string.isNotBlank(accType)){
                return ([select Id,Name,Type,Rating,SLA__c from Account where Type =: accType]);
            }
            else {
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string DeleteSelectedAccounts(List<Id> accIdList){
        try {
            if(!accIdList.isEmpty()){
                 delete ([select Id from Account where Id IN : accIdList]);
                return 'Selected Records Have been Deleted Succesfully';
            }
            else{
                return 'There is no selected records';
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}