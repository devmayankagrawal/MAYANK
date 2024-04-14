public with sharing class AccountProvider {
    
    @AuraEnabled
    public static String createAccountRecord(Account objAcc){
        try {
            insert objAcc;
            return 'Record created successfully...!!!';
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    
    @AuraEnabled
    public static Account searchAccount(Account objAcc){
        try {
            if(objAcc != null){
                return ([select Id, Name, Type, Rating, SLA__c,Description from Account where Name=: objAcc.Name LIMIT 1] );
            }
            else{
                return null;
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static string updateAccount(Account objAcc){
        try {
            if(objAcc !=null){
                Database.update(objAcc,false);
                return 'Record Updated SUccesfully!!!..';
            }
            else{
                return 'Locha!!..Something went wrong';
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string deleteAccount(Account objAcc){
        try {
            if(objAcc !=null){
                delete objAcc;
                return 'Your Account Record has been Successfully Deleted';
            }
            else{
                return 'Loacha!!..Something went wrong';
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string undeleteAccount(Account objAcc){
        try {
            Account objAccUndeleted =   [select Id, Name, Rating from Account where Name=:objAcc.Name and isDeleted=true LIMIT 1 ALL ROWS ];
            System.debug('#Record Found in Recycle Bin '+objAccUndeleted);
            
            undelete objAccUndeleted;
            return 'Record has been undeleted';
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static List<Account> getAllAccountsType(string accType){
        try {
            if(String.isNotBlank(accType)){
                
                
                return ([select ID, Name,Type, Rating, SLA__c from Account where Type=: accType WITH SECURITY_ENFORCED]);
            }
            else{
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
     @AuraEnabled
    public static List<Account> getAccountsType(Account objAcc){
        try {
            if(objAcc != null){
                
                
                return ([select ID, Name,Type, Rating, SLA__c from Account where Type=: objAcc.Type ]);
            }
            else{
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static string deleteSelectedAccounts(List<ID> accIDList){
        try {
            if(!accIDList.isEmpty()){
                delete ([select Id from Account where Id IN : accIDList]);
                return 'Selected Records have been deleted successfully';
            }
            else {
                return 'There is no records are selected';
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static List<Opportunity> searchOpportunity(Opportunity objOpp){
        try {
            if(objOpp != null) {
                ID accountId = [select id from Account where Name= : objOpp.AccountId].id;
                return [select Id, Name, Account.Name, CloseDate, StageName from Opportunity where AccountId =: accountId and StageName =: objOpp.StageName];
            }
            else {
                return null;
            }
             
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }
    
	@AuraEnabled
    public static List<Opportunity> searchCurrentOpportunities(String accId){
        try {
            Id accountId = Id.valueOf(accId);
            
            System.debug('#Calling '+accountId);
            return ([select Id,Name,StageName,CloseDate,Amount,Account.Name from Opportunity where AccountId=:accountId ]);
            
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
	@AuraEnabled
    public static List<Opportunity> deleteSelectedOpportunity(List<Opportunity> oppList,string accId){
        try {
            if(!oppList.isEmpty()){
                Database.delete (oppList,false);
                system.debug('#Record Deleted'+oppList);
                return ([select Id,Name,StageName,CloseDate,Amount,Account.Name from Opportunity where AccountId=:accId ]);
                
            }
            else {
                return null;
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

	@AuraEnabled
   public static list<Contact> searchContact(Account objAcc){
       system.debug('#Soql');
       try {
          		Id AccId=[select Id from Account where Name=:objAcc.Name].Id;
               return([select Id,Name,Level__c,LeadSource,FirstName,LastName,AccountId from Contact where AccountId=:AccId]);
         	
           
       } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
       }
   }    
    
     @AuraEnabled
   public static list<Contact> deleteContact(list<Contact> ConList){
       system.debug('#Soql');
       try {
           Database.delete(ConList,false);
           string AccId;
           for(Contact c:ConList){
               AccId=c.AccountId;
           }
          		
               return([select Id,Name,Phone,Level__c,LeadSource,FirstName,LastName from Contact where AccountId=:AccId]);
         	
           
       } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
       }
   }
    
    @AuraEnabled
    public static list<Opportunity> searchAccountOpportunity(Account objAcc){
       system.debug('#Soql');
       try {
          	   Account accObject  = [select id from Account where Name=:objAcc.Name];
               return([select Id,Name,StageName,CloseDate,Amount from Opportunity where AccountId=:accObject.Id]);
         	
           
       } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
       }
   }
	
	 @AuraEnabled
    public static List<Opportunity> deleteOpportunities(List<Opportunity> accList, Account accObject){
        try {
            
              Database.delete(accList, false);
            
              Account objAcc = [select Id from Account where Name=:accObject.Name];
              return ([select Id,Name,StageName,CloseDate,Amount from Opportunity where AccountId= :objAcc.Id ]);              
            
            
                        
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }    
}