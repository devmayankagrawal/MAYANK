trigger ApplicantTrigger15April1 on Applicant__c (before insert, before update) {
    
    set<string> appEmailSet = new set<string>();
    for(Applicant__c objApp : trigger.new){
        if(string.isNotBlank(objApp.Email_ID__c)){
            if(trigger.isInsert && trigger.isBefore){
                appEmailSet.add(objApp.Email_ID__c);
            }
            if(trigger.isUpdate && trigger.isBefore){
                If(objApp.Email_ID__c != trigger.oldMap.get(objApp.Id).Email_ID__c){
                    appEmailSet.add(objApp.Email_ID__c);
                }
            }
        }
    }
        Map<string,Applicant__c> appMap = new Map<string,Applicant__c>();
    if(!appEmailSet.isEmpty()){
        for(Applicant__c objApp : [select Id, Email_ID__c from Applicant__c where Email_ID__c IN : appEmailSet]){
            appMap.put(objApp.Email_ID__c, objApp);
        }
    }
    if(!appMap.isEmpty()){
        for(Applicant__c objApp : trigger.new){
            If(appMap.containsKey(objApp.Email_ID__c)){
                objApp.Email_ID__c.addError(objApp.Email_ID__c+ 'This type of email record already exists');
            }
        }
    }
}