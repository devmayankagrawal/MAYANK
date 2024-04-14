trigger CountOfConTrigger on Contact (after insert,after update,after delete,after undelete) {
    
    set<Id> accIdSet = new set<Id>();
    if((trigger.isInsert || trigger.isUpdate || trigger.isUndelete) && trigger.isAfter){
        for(Contact objCon : trigger.new){
            system.debug(trigger.new);
            if(objCon.AccountId != null){
                if((trigger.isInsert || trigger.isUndelete) && trigger.isAfter){
                    accIdSet.add(objCon.AccountId);
                }
                if(trigger.isUpdate && trigger.isAfter){
                    if(objCon.AccountId != trigger.oldMap.get(objCon.Id).AccountId){
                        accIdSet.add(objCon.AccountId);
                        accIdSet.add(trigger.oldMap.get(objCon.Id).AccountId);
                    }
                }
            }
        }
    }
    if(trigger.isDelete && trigger.isAfter){
        for(Contact objCon : trigger.old){
            if(objCon.AccountId != null){
                accIdSet.add(objCon.AccountId);
            }
        }
    }
    Map<Id,Account> accMap = new Map<Id,Account>();
    
    if(!accIdSet.isEmpty()){
        for(Account objAcc : [select Id,(select Id from Contacts) from Account where Id IN : accIdSet]){
            objAcc.Count_of_Contact__c = objAcc.Contacts.size();
            accMap.put(objAcc.Id,objAcc);
        }
    }
    
    if(!accMap.isEmpty()){
        Database.update(accMap.values(),false);
    }
    
    
    
    
    
    
}