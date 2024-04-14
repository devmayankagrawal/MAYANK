trigger PassportTrigger on Passport__c (after insert, after update) {
    
    set<Id> applicantIdSet = new set<Id>();
    for(Passport__c objPass : trigger.new){
        if(objPass.Applicant__c != null){
            if(trigger.isInsert && trigger.isAfter){
                applicantIdSet.add(objPass.Applicant__c);  
            }
            if(trigger.isUpdate && trigger.isAfter){
                if(objPass.Issue_Date__c != trigger.oldMap.get(objPass.Id).Issue_Date__c){
                    applicantIdSet.add(objPass.Applicant__c); 
                }
            }
        }
    }
    Map<Id,Applicant__c> applicantMap = new Map<Id,Applicant__c>();
    if(!applicantIdSet.isEmpty()){
        for(Applicant__c objApplicant : [select Id, Passport_Message__c from Applicant__c where Id IN : applicantIdSet]){
            applicantMap.put(objApplicant.Id, objApplicant);
        }
    }
    if(!applicantMap.isEmpty()){
        for(Passport__c objPass : trigger.new){
            if(applicantMap.containsKey(objPass.Applicant__c)){
                if(objPass.Issue_Date__c.month()==9){
                    applicantMap.get(objPass.Applicant__c).Passport_Message__c='Expired';
                }
                else{
                    if(objPass.Issue_Date__c.month()==12){
                        applicantMap.get(objPass.Applicant__c).Passport_Message__c='In Progress';
                    }
                    else{
                        applicantMap.get(objPass.Applicant__c).Passport_Message__c='Dispatched';
                        
                    }
                }
            }
        }
    }
    List<Applicant__c> applicantListUpdate = new List<Applicant__c>();
    applicantListUpdate.addAll(applicantMap.values());
    
    if(!applicantListUpdate.isEmpty()){
        Database.update(applicantListUpdate,false);
    }
}