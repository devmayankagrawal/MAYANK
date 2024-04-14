trigger ApplicantTrigger on Applicant__c (before insert, before Update) {

    for(Applicant__c objApp : trigger.new){
        if(objApp.Gender__c=='Male'){
            objApp.Police_Verification__c=true;
        }
        else{
            objApp.Police_Verification__c=false;
        }
    }
}