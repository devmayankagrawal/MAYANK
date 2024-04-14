trigger AddressTriggerToApplicant on Address__c (after insert, after update) {
    
    set<Id> applicantIdSet = new set<Id>();
    for(Address__c objAdr : trigger.new){
        if(objAdr.Applicant__c != null){
            if(trigger.isInsert && trigger.isAfter){
                applicantIdSet.add(objAdr.Applicant__c);
            }
            if(trigger.isUpdate && trigger.isAfter){
                if(objAdr.City__c != trigger.oldMap.get(objAdr.Id).City__c){
                    applicantIdSet.add(objAdr.Applicant__c);
                    
                }
            }
        }
    }
    Map<Id,Applicant__c> applicantMap = new Map<Id,Applicant__c>();
    if(!applicantIdSet.isEmpty()){
        for(Applicant__c objApplicant : [select Id, Police_Verification__c from Applicant__c where Id IN : applicantIdSet]){
            applicantMap.put(objApplicant.Id, objApplicant);
        }
    }
    if(!applicantMap.isEmpty()){
        for(Address__c objAdr : trigger.new){
            if(applicantMap.containsKey(objAdr.Applicant__c)){
                if(objAdr.City__c=='New Nagpur'){
                    applicantMap.get(objAdr.Applicant__c).Police_Verification__c= true;
                }
                else{
                    applicantMap.get(objAdr.Applicant__c).Police_Verification__c= false;
                    
                }
            }
        }
    }
    List<Applicant__c> applicantListUpdate = new List<Applicant__c>();   
    applicantListUpdate.addAll(applicantMap.values());
    
    if(!applicantListUpdate.isEmpty())
        Database.update(applicantListUpdate, false);
}