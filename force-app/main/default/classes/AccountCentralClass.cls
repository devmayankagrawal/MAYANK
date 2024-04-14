public with sharing class AccountCentralClass {
   @AuraEnabled
   public static String createAccountRecordData(Account objAcc){
       try {

        insert objAcc;
        return 'Record Created Successfully';
           
       } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
       }
   }
   @AuraEnabled
   public static Account searchAccountRecord(Account objAcc){
       system.debug('#Account Searched='+objAcc);
    
    try {
        if(objAcc != null){
            return ([select Id, Name, Type, Rating, SLA__c from Account where Name=: objAcc.Name WITH SECURITY_ENFORCED] );
            
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
                if (objAcc != null) {
                    Database.update(objAcc, False);
                    return 'Record Updated Successfully';
                }
                else {
                    return 'Locha..Your Record is not Updated';
                }
       } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
       }
   }
   @AuraEnabled
   public static string deleteAccountRecord(Account objAcc){
       try {
           If(objAcc !=null){
               delete objAcc;
               return 'Record Deleted Successfully';

           }
            else {
                return 'Locha..!!Something Went Wrong';
            }
       } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
       }
   }
   @AuraEnabled
   public static string undeleteAccountRecord(Account objAcc){
       try {
               Account objAccUndeleted = [select Id, Name, Rating, SLA__c from Account where Name=: objAcc.Name and isDeleted=true LIMIt 1 ALL Rows];
               System.debug('#Record Found in Recycle Bin '+objAccUndeleted);
          

               undelete objAccUndeleted;
               return 'record has been undeleted';
       } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
       }
   }
   @AuraEnabled
   public static List<Account> getAllAccountType(String accType){
       try {
           If(String.isNotBlank(accType)){
               return  ([select Id, Name, Type, Rating, SLA__c from Account where Type=: accType]);

           }
           else {
               return null;
           }
           
       } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
       }
   }
}