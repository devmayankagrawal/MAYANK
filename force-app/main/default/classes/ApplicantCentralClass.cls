public with sharing class ApplicantCentralClass {
    
    @AuraEnabled
    public static void createApplicantRecords(Applicant__c objApp){
        try {
            insert objApp;
            system.debug('#Applicant record created='+objApp);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}