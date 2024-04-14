trigger AccountToCaseTriggerSelf on Account (before update) {
    
    Map<ID,Account> accMap = new Map<ID,Account>();
    for(Account objAcc : trigger.new){
        if(objAcc.SLA__c != trigger.oldMap.get(objAcc.Id).SLA__c){
            accMap.put(objAcc.Id,objAcc);
        }
    }
    List<Case> caseList = new List<case>();
    if(!accMap.isEmpty()){
        for(Case objCase : [select Id, CaseNumber, Status, AccountId from Case where AccountId IN : accMap.keySet()]){
            caseList.add(objCase);
        }
    }
    if(!caseList.isEmpty()){
        for(Case objCase : caseList){
            if(accMap.containsKey(objCase.AccountId)){
                if((trigger.oldMap.get(objCase.AccountId).SLA__c=='Silver') && (accMap.get(objCase.AccountId).SLA__c=='Gold') && (objCase.Status=='Escalated')){
                    accMap.get(objCase.AccountId).Description = objCase.CaseNumber;
                }
                else{
                    accMap.get(objCase.AccountId).Description = '';
                    
                }
            }
        }
    }
}