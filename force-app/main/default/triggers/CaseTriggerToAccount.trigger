trigger CaseTriggerToAccount on Case (after insert, after update) {
    
    set<Id> accountIdSet = new set<Id>();
    for(Case objCase : trigger.new){
        if(objCase.AccountId != null){
            if(trigger.isInsert && trigger.isAfter){
                accountIdSet.add(objCase.AccountId);
            }
            if(trigger.isUpdate && trigger.isAfter){
                if(objCase.Priority != trigger.oldMap.get(objCase.Id).Priority){
                    accountIdSet.add(objCase.AccountId);  
                }
            }
        }
    }
    Map<Id,Account> accountMap = new Map<Id,Account>();
    if(!accountIdSet.isEmpty()){
        for(Account objAcc : [select Id, Name, Rating from Account where Id IN : accountIdSet]){
            accountMap.put(objAcc.Id, objAcc);
        }
    }
    if(!accountMap.isEmpty()){
        for(Case objCase : trigger.new){
            if(accountMap.containsKey(objCase.AccountId)){
                if((objCase.Priority=='High') || (objCase.Priority=='Medium')){
                    accountMap.get(objCase.AccountId).Rating='Hot';
                }
                else{
                    accountMap.get(objCase.AccountId).Rating='';
                }
            }
        }
    }
    List<Account> accListUpdate = new List<Account>();
    accListUpdate.addAll(accountMap.values());
    
    if(!accListUpdate.isEmpty()){
        Database.update(accListUpdate,false);
    }
}