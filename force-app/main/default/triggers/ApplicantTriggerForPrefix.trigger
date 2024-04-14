trigger ApplicantTriggerForPrefix on Applicant__c (before insert, before update) {
    
    set<string> appGenderSet = new set<string>();
    for(Applicant__c objApp : trigger.new){
        if(string.isNotBlank(objApp.Gender__c)){
            if(trigger.isInsert && trigger.isBefore){
                appGenderSet.add(objApp.Gender__c);
            }
            if(trigger.isUpdate && trigger.isBefore){
                if(objApp.First_Name__c != trigger.oldMap.get(objApp.Id).First_Name__c){
                    appGenderSet.add(objApp.Gender__c);
                }
            }
        }
    }
    
    Map<String,Applicant__c> appMap = new Map<String,Applicant__c>();
    if(!appGenderSet.isEmpty()){
        for(Applicant__c objApp : [select Id, First_Name__c, Last_Name__c, Gender__c from Applicant__c where Gender__c IN : appGenderSet]){
            appMap.put(objApp.Gender__c, objApp);
        }
    }
    if(!appMap.isEmpty()){
        for(Applicant__c objApp : trigger.new){
            if(appMap.containsKey(objApp.Gender__c)){
                if(objApp.Gender__c=='Male'){
                    objApp.First_Name__c = 'Mr. ' +objApp.First_Name__c;
                }
                else{
                    if(objApp.Gender__c=='Female'){
                        objApp.First_Name__c = 'Ms. ' +objApp.First_Name__c;
                    }
                    else{
                        objApp.First_Name__c = '' + objApp.First_Name__c;
                    }
                }
            }
        }
    }
    
}