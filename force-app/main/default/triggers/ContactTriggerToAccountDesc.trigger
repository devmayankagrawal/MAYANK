trigger ContactTriggerToAccountDesc on Contact (after insert, after Update) {
    
    set<Id> accIdSet = new set<Id>();
    for(Contact objCon : trigger.new){
        if(objCon.AccountId != null){
            if(trigger.isInsert && trigger.isAfter){
                accIdSet.add(objCon.AccountId);
            }
            if(trigger.isUpdate && trigger.isAfter){
                if((objCon.FirstName != trigger.oldMap.get(objCon.Id).FirstName) || (objCon.LastName != trigger.oldMap.get(objCon.Id).LastName)){
                    accIdSet.add(objCon.AccountId);
                }
            }
        }
        
    }
    Map<Id,Account> accMap = new Map<Id,Account>();
    if(!accIdSet.isEmpty()){
        for(Account objAcc : [select Id, Name, Description from Account where Id IN : accIdSet]){
            accMap.put(objAcc.Id, objAcc);
        }   
    }
    if(!accMap.isEmpty()){
        for(Contact objCon : trigger.new){
            if(accMap.containsKey(objCon.AccountId)){
                
                    accMap.get(objCon.AccountId).Description =objCon.FirstName + ' ' + objCon.LastName;
                
               
            }
        }
    }
    List<Account> accListUpdate = new List<Account>();
    accListUpdate.addAll(accMap.values());
    
    if(!accListUpdate.isEmpty()){
        Database.Update(accListUpdate,false);
    }
    
    
    
}