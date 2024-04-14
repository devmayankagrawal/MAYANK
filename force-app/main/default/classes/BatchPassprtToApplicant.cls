global class BatchPassprtToApplicant implements database.Batchable<sObject>{
    
    global database.QueryLocator start(database.BatchableContext BC){
        return database.getQueryLocator('select Id,Status__c,Applicant__c,Applicant__r.Police_Verification__c,Applicant__r.Gender__c from Passport__c where Applicant__r.Police_Verification__c=true and (Applicant__r.Gender__c=\'Male\' OR Applicant__r.Gender__c=\'Female\')');
    }
    
    global void execute(database.BatchableContext BC,List<Passport__c> passList){
        set<Id> appIdSet = new set<Id>();
        if(!passList.isEmpty()){
            for(Passport__c objPass : passList){
                if(objPass.Applicant__c != null)
                    appIdSet.add(objPass.Applicant__c); 
            }
        }
        
        Map<Id,Applicant__c> appMap = new Map<Id,Applicant__c>();
        if(!appIdSet.isEmpty()){
            for(Applicant__c objApp : [select Id, My_Rejected_Passports__c, My_Dispatched_Passports__c, My_Re_New_Passports__c from Applicant__c where Id IN :appIdSet]){
                appMap.put(objApp.Id,objApp);
            }
        }
        if(!appMap.isEmpty()){
            for(Passport__c objPass : passList){
                if(appMap.containsKey(objPass.Applicant__c)){
                    if(objPass.Status__c=='Rejected'){
                        appMap.get(objPass.Applicant__c).My_Rejected_Passports__c = objPass.Status__c;
                    }
                    else{
                        if(objPass.Status__c=='Dispatched'){
                            appMap.get(objPass.Applicant__c).My_Dispatched_Passports__c = objPass.Status__c;
                        }
                        else{
                            if(objPass.Status__c=='Renew'){
                                appMap.get(objPass.Applicant__c).My_Re_New_Passports__c = objPass.Status__c;
                            }
                        }
                    }
                }
            }
            Database.update(appMap.values(),False);
        }
    }
    
    global void finish(database.BatchableContext BC){
        
    }
}