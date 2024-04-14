trigger PrefixApplicantTrigger on Applicant__c (before insert,before update) {

    if(trigger.isInsert && trigger.isBefore){
        PrefixApplicantHandler.beforeInsert(trigger.new);
    }
    if(trigger.isUpdate && trigger.isBefore){
        PrefixApplicantHandler.beforeUpdate(trigger.new);
    }
}