trigger OpportunityToAccountSelf on Opportunity (before insert, before update) {
    
    set<Id> accountIdSet = new set<Id>();
    for(Opportunity objOpp : trigger.new){
        if(objOpp.AccountId != null){
            if(trigger.isInsert && trigger.isBefore){
                accountIdSet.add(objOpp.AccountId);
            }
            if(trigger.isUpdate && trigger.isBefore){
                if(objOpp.Name != trigger.oldMap.get(objOpp.Id).Name){
                    accountIdSet.add(objOpp.AccountId);
                }
            }
        }
    }
    Map<Id,Account> accountMap = new Map<Id,Account>();
    if(!accountIdSet.isEmpty()){
        for(Account objAcc : [select Id, Name, Rating, SLA__c from Account where Id IN : accountIdSet]){
            accountMap.put(objAcc.Id, objAcc);
        }
    }
    if(!accountMap.isEmpty()){
        for(Opportunity objOpp : trigger.new){
            if(accountMap.containsKey(objOpp.AccountId)){
                if(accountMap.get(objOpp.AccountId).Rating=='Hot' || accountMap.get(objOpp.AccountId).Rating=='Warm'){
                    objOpp.Type='Existing Customer - Upgrade';
                }
                else{
                    objOpp.Type='';
                }
                objOpp.Description = accountMap.get(objOpp.AccountId).SLA__c;
            }            
        }
    }
}