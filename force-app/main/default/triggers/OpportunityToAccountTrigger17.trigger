trigger OpportunityToAccountTrigger17 on Opportunity (after insert, after update) {
    
    set<Id> accountIdSet = new set<Id>();
    for(Opportunity objOpp : trigger.new){
        if(objOpp.AccountId != null){
            if(trigger.isInsert && trigger.isAfter){
                accountIdSet.add(objOpp.AccountId);
            }
            if(trigger.isUpdate && trigger.isAfter){
                if((objOpp.StageName != trigger.oldMap.get(objOpp.Id).StageName) && (objOpp.Amount != trigger.oldMap.get(objOpp.Id).Amount)){
                    accountIdSet.add(objOpp.AccountId);
                    
                }
            }
        }
    }
    Map<Id,Account> accountMap = new Map<Id,Account>();
    If(!accountIdSet.isEmpty()){
        for(Account objAccount : [select Id, Ownership from Account where Id IN : accountIdSet]){
            accountMap.put(objAccount.Id, objAccount);
        }
    }
    if(!accountMap.isEmpty()){
        for(Opportunity objOpp : trigger.new){
            if(accountMap.containsKey(objOpp.AccountId)){
                if(objOpp.StageName=='Value Proposition' && objOpp.Amount < 50000){
                    accountMap.get(objOpp.AccountId).Ownership = 'Private';
                }
                else{
                    if(objOpp.StageName=='Perception Analysis' && objOpp.Amount > 50000){
                        accountMap.get(objOpp.AccountId).Ownership = 'Public';
                    }
                    else{
                        accountMap.get(objOpp.AccountId).Ownership = '';
                        
                    }
                }
            }
        }
    }
    List<Account> accountUpdateList = new List<Account>();
    accountUpdateList.addAll(accountMap.values());
    
    if(!accountUpdateList.isEmpty()){
        Database.update(accountUpdateList,false);
    }
}