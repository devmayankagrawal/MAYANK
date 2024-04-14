trigger ApplicantTriggerToAddress on Applicant__c (after update) {
    
    Map<Id,Applicant__c> appMap = new Map<Id,Applicant__c>();
    for(Applicant__c objApp : trigger.old){
        if((objApp.Police_Verification__c != trigger.newMap.get(objApp.Id).Police_Verification__c) || (objApp.Gender__c != trigger.newMap.get(objApp.Id).Gender__c)){
            appMap.put(objApp.Id, objApp);
        }
    }
    List<Address__c> adrList = new List<Address__c>();
    if(!appMap.isEmpty()){
        for(Address__c objAdr : [select Id, Country__c, State__c, City__c, Applicant__c from Address__c where Applicant__c IN : appMap.keySet() and Pincode__c like '44%']){
            adrList.add(objAdr);
        }
    }
    if(!adrList.isEmpty()){
        for(Address__c objAdr : adrList){
            if(appMap.containsKey(objAdr.Applicant__c)){
                if(appMap.get(objAdr.Applicant__c).Police_Verification__c && appMap.get(objAdr.Applicant__c).Gender__c=='Male' ){
                    objAdr.Country__c='India';
                    objAdr.State__c='Maharashtra';
                    objAdr.City__c='Pune';
                }
                else{
                    objAdr.Country__c='';
                    objAdr.State__c='';
                    objAdr.City__c='';
                }
            }
        }
        Database.update(adrList,False);
    }
}