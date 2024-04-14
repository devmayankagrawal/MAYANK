trigger ContactTriggerDesc on Contact (after insert,after update) {
    
    set<Id> accountIdSet = new set<Id>();
    
    for(Contact objCon : trigger.new){
        if(objCon.AccountId != null){
            if(trigger.isInsert && trigger.isAfter){
                accountIdSet.add(objCon.AccountId);
            }
            if(trigger.isUpdate && trigger.isAfter){
                if(objCon.Phone != trigger.oldMap.get(objCon.Id).Phone){
                    accountIdSet.add(objCon.AccountId);
                }
            }
        }
    }
    
    Map<Id,Account> accountMap = new Map<Id,Account>();
    
    if(!accountIdSet.isEmpty()){
        for(Account objAccount : [select Id,Phone from Account where Id IN : accountIdSet]){
            accountMap.put(objAccount.Id,objAccount);
        }
    }
    
    if(!accountMap.isEmpty()){
        for(Contact objCon : trigger.new){
            if(accountMap.containsKey(objCon.AccountId)){
                accountMap.get(objCon.AccountId).Phone = objCon.Phone;
            }
        }
        Database.update(accountMap.values());
    }
    
    
}