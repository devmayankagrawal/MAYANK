trigger ApplicantTriggerToPassport on Applicant__c (before update) {
    
    Map<Id,Applicant__c> appMap = new Map<Id,Applicant__c>();
    for(Applicant__c objApp : trigger.new){
        if(objApp.Gender__c != trigger.oldMap.get(objApp.Id).Gender__c){
            appMap.put(objApp.Id, objApp);
        }
    }
    List<Passport__c> passList = new List<Passport__c>();
    if(!appMap.isEmpty()){
        for(Passport__c objPass : [select Id, Passport_Number__c, Issue_Date__c, Status__c, Applicant__c from Passport__c where Applicant__c IN :appMap.keySet()]){
            passList.add(objPass);
        }
    }
    if(!passList.isEmpty()){
        for(Passport__c objPass : passList){
            if(appMap.containsKey(objPass.Applicant__c)){
                if(trigger.oldMap.get(objPass.Applicant__c).Gender__c=='Female'){
                    if(objPass.Status__c=='Rejected' && objPass.Issue_Date__c.month() == 4){
                        appMap.get(objPass.Applicant__c).Passport_Message__c = objPass.Passport_Number__c;
                    }
                    else{
                        appMap.get(objPass.Applicant__c).Passport_Message__c = '';
                        
                    }
                }
                else{
                    appMap.get(objPass.Applicant__c).Passport_Message__c = '';
                    
                }
            }
        }
    }
}