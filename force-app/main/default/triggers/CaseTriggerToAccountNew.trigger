trigger CaseTriggerToAccountNew on Case (after insert, after update) {
    
    set<Id> accountIdSet = new set<Id>();
    for(Case objCase : trigger.new){
        If(objCase.AccountId != null){
            if(trigger.isInsert && trigger.isAfter){
                accountIdSet.add(objCase.AccountId);
            }
            if(trigger.isUpdate && trigger.isAfter){
                if(objCase.Type != trigger.oldMap.get(objCase.Id).Type){
                    accountIdSet.add(objCase.AccountId);  
                }
            }
        }
    }
    Map<Id,Account> accountMap = new Map<Id,Account>();
    if(!accountIdSet.isEmpty()){
        for(Account objAcc : [select Id, Name, Industry from Account where Id IN : accountIdSet]){
            accountMap.put(objAcc.Id, objAcc);
        }
    }
    if(!accountMap.isEmpty()){
        for(Case objCase : trigger.new){
            if(accountMap.containsKey(objCase.AccountId)){
                if(objCase.Type=='Structural'){
                    accountMap.get(objCase.AccountId).Industry = 'Construction';
                }
                else{
                    if(objCase.Type=='Electrical'){
                        accountMap.get(objCase.AccountId).Industry = 'Engineering';
                    }
                    else{
                        accountMap.get(objCase.AccountId).Industry = '';
                    }
                }
            }
        }
    }
    List<Account> accountListUpdate = new List<Account>();
    accountListUpdate.addAll(accountMap.values());
    
    if(!accountListUpdate.isEmpty()){
        Database.update(accountListUpdate,false);
    }
}