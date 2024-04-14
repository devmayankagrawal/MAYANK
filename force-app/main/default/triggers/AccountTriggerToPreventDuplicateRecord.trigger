trigger AccountTriggerToPreventDuplicateRecord on Account (before insert, before update) {

    set<string> accountNameSet = new set<string>();
    for(Account objAcc : trigger.new){
        if(string.isNotBlank(objAcc.Name)){
            if(trigger.isInsert && trigger.isBefore){
                accountNameSet.add(objAcc.Name);
            }
            if(trigger.isUpdate && trigger.isBefore){
                if(objAcc.Name != trigger.oldMap.get(objAcc.Id).Name){
                    accountNameSet.add(objAcc.Name);
                }
            }
        }
    }
    Map<string,Account> accountMap = new Map<string,Account>();
    if(!accountNameSet.isEmpty()){
        for(Account objAcc : [select Id, Name from Account where Name IN : accountNameSet]){
            accountMap.put(objAcc.Name, objAcc);
        }
    }
    if(!accountMap.isEmpty()){
        for(Account objAcc : trigger.new){
            if(accountMap.containsKey(objAcc.Name)){
                objAcc.addError(objAcc.Name + ' This Account already exists ');
            }
        }
    }
}