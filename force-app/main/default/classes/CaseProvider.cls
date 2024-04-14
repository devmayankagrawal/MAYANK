public with sharing class CaseProvider {
   
    @AuraEnabled
    public static List<Case> getAllCaseStatus(String caseStatus){
        try {
           
            if(String.isNotBlank(caseStatus)){
                return ([Select Id,CaseNumber,Status,Priority,Origin,Type from Case where Status =: caseStatus WITH SECURITY_ENFORCED]);
            }else{
                return null;
                                }       
           
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Case> getCaseStatus(String caseStatus){
        try {
            if(String.isNotBlank(caseStatus)){
                return([Select Id,CaseNumber,Status,Priority,Origin,Type from Case where Status =: caseStatus WITH SECURITY_ENFORCED]);
            }
            else{
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
        
        @AuraEnabled
    public static List<Case> getCaseDetails(Case objCase){
        try {
            if(objCase != null){
                return([Select Id,CaseNumber,Status,Priority,Origin,Type from Case where CaseNumber=: objCase.CaseNumber]);
            }
            else{
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static Case getCaseRecords(Case objCase){
        try {
            if(objCase != null){
                return([Select Id,CaseNumber,Status,Reason,Priority,Origin,Type from Case where CaseNumber=: objCase.CaseNumber LIMIT 1]);
            }
            else{
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static Case updateCaseRecordsNew(Case objCase){
       
        if(objCase!=null){
            objCase.Status = 'New';
            objCase.Case_Escalation_Reason__c='';
            Database.update(objCase, false);
        }
        return ([select id,CaseNumber,Status,Reason from Case where CaseNumber=:objCase.CaseNumber LIMIT 1]);
    }
	
    @AuraEnabled
    public static Case escalateCaseRecords(Case objCase){
        system.debug('#Data='+objCase);
        if(objCase!=null){
            objCase.Status = 'Escalated';           
            Database.update(objCase, false);
        }
        return ([select id,CaseNumber,Status,Reason,Priority from Case where CaseNumber=:objCase.CaseNumber LIMIT 1]);
    }

}