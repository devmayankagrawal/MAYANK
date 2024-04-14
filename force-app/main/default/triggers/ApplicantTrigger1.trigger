trigger ApplicantTrigger1 on Applicant__c (before insert, before update) {

    for(Applicant__c objApp : trigger.new){
        if(string.isBlank(objApp.PAN_Card__c)){
            objApp.PAN_Card__c.addError('PanCard should not be Blank');
        }
    }
}