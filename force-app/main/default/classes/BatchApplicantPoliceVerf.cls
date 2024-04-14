global class BatchApplicantPoliceVerf implements database.Batchable<sObject>{
    
    global database.QueryLocator start(Database.BatchableContext BC){
       return database.getQueryLocator('select Id,Gender__c,Police_Verification__c from Applicant__c where Gender__c=\'Male\'');
    }
    
    global void execute(Database.BatchableContext BC,List<Applicant__c> appList){
        
        if(!appList.isEmpty()){
            for(Applicant__c objApp : appList){
                objApp.Police_Verification__c=true;
            }
            Database.update(appList,false);
        }
    }
    
    global void finish(Database.BatchableContext BC){
        database.executeBatch(new BatchApplicantMail());
    }
    
}