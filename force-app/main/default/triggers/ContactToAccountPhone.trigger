trigger ContactToAccountPhone on Contact (after insert, after update) {
    
    set<Id> accIdSet = new set<Id>();
    for(Contact objCon : trigger.new){
        if(objCon.AccountId != null){
            if(trigger.isInsert && trigger.isAfter){
                accIdSet.add(objCon.AccountId);
            }
            if(trigger.isUpdate && trigger.isAfter){
                if(objCon.Phone != trigger.oldMap.get(objCon.Id).Phone){
                    accIdSet.add(objCon.AccountId);
                }
            }
        }
    }
    Map<Id,Account> accMap = new Map<Id,Account>();
    if(!accIdSet.isEmpty()){
        for(Account objAcc : [select Id, Phone from Account where Id IN : accIdSet]){
            accMap.put(objAcc.Id, objAcc);
        }
    }
    if(!accMap.isEmpty()){
        for(Contact objCon : trigger.new){
            if(accMap.containsKey(objCon.AccountId)){
                accMap.get(objCon.AccountId).Phone = objCon.Phone;
            }
        }
    }
    List<Account> accListUpdate = new List<Account>();
    accListUpdate.addAll(accMap.values());
    
    if(!accListUpdate.isEmpty()){
        Database.update(accListUpdate,false);
    }    
}