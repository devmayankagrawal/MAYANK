trigger ContactToAccountSelf on Contact (before insert, before update) {

    set<Id> accIdSet = new set<Id>();
    for(Contact objCon : trigger.new){
        if(objCon.AccountId !=null){
            if(trigger.isInsert && trigger.isBefore){
                accIdSet.add(objCon.AccountId);
            }
            if(trigger.isUpdate && trigger.isBefore){
                If((objCon.FirstName != trigger.oldMap.get(objCon.Id).FirstName) ||(objCon.LastName != trigger.oldMap.get(objCon.Id).LastName)){
                    accIdSet.add(objCon.AccountId);
                }
            }
        }
    }
    Map<Id,Account> accMap = new Map<Id,Account>();
    if(!accIdSet.isEmpty()){
        for(Account objAcc : [select Id, Name, Type, Rating from Account where Id IN : accIdSet]){
            accMap.put(objAcc.Id, objAcc);
        }
    }
    If(!accMap.isEmpty()){
        for(Contact objCon : trigger.new){
            if(accMap.containsKey(objCon.AccountId)){
                if(accMap.get(objCon.AccountId).Type=='Prospect'){
                    objCon.LeadSource='Purchased List';
                }
                else{
                    objCon.LeadSource='';
                }
                    objCon.Description = accMap.get(objCon.AccountId).Rating;
            }
        }
    }
    
    
    
    
    
    
}