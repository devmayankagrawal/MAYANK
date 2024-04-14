public with sharing class CentralApplicantClass {
    
    @AuraEnabled
    public static void createApplicantRecord(Applicant__c objApp){
        try {
            insert objApp;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Applicant__c> getAllAccountsGender(String appGender){
        try {
            if(String.isNotBlank(appGender)){
                return ([select Id,First_Name__c,Last_Name__c,Gender__c from Applicant__c where Gender__c =: appGender]);
            }
            else {
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Address__c> searchAddresses(string appName){
        try {
            Id appId15 = [select Id from Applicant__c where Name =: appName].Id;

            return ([select Id,Name,Country__c,State__c,City__c from Address__c where Applicant__c =: appId15]);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string deleteAddresses(List<Id> adrList){
        try {
            if(!adrList.isEmpty()){
                Database.delete([select Id from Address__c where Id IN : adrList],false);
                return 'Your Records Have been deleted Successfully..';
            }
            else{
                return 'Empty records';
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Address__c> searchApplicantAddresses(Applicant__c objApp){
        try {
            Id appId15 = [select Id from Applicant__c where Name =: objApp.Name].Id;

            return ([select Id,Name,Country__c,State__c,City__c from Address__c where Applicant__c =: appId15]);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}