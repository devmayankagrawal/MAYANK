trigger ApplicantTrigger15April on Applicant__c (before insert, before update) {
    
    set<String> applicantMobileSet = new set<string>();
    for(Applicant__c objApp : trigger.new){ 
        if(objApp.Mobile_Number__c != null){
            if(trigger.isInsert && trigger.isBefore){
                applicantMobileSet.add(string.valueOf(objApp.Mobile_Number__c));
            }
            if(trigger.isUpdate && trigger.isBefore){
                if(objApp.Mobile_Number__c != trigger.oldMap.get(objApp.Id).Mobile_Number__c){
                    applicantMobileSet.add(string.valueOf(objApp.Mobile_Number__c));
           
                }
            }
        }
    }
            delete([select Id from Applicant__c where Mobile_Number__c IN : applicantMobileSet ]);
}