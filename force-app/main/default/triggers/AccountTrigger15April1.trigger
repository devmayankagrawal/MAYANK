trigger AccountTrigger15April1 on Account (before insert, before update) {
    
    Set<String> accountNameSet = new Set<String>();
    for(Account objAcc : trigger.new){
        if(string.isNotBlank(objAcc.name)){
            if(trigger.isInsert && trigger.isBefore){
                accountNameSet.add(ObjAcc.Name);
            }
            if(trigger.isUpdate && trigger.isBefore){
                if(objAcc.Name != trigger.oldMap.get(objAcc.Id).Name){
                    accountNameSet.add(ObjAcc.Name);
                }
            }
        }
    }
    Map<String,Account> accMap = new Map<String,Account>();
    
    if(!accountNameSet.isEmpty()){
        for(Account objAcc : [select Id, Name from Account where Name IN : accountNameSet]){
            accMap.put(objAcc.Name, objAcc);
        }
    }
    if(!accMap.isEmpty()){
        for(Account objAcc : trigger.new){
            if(accMap.containsKey(objAcc.Name)){
                objAcc.addError(objAcc.Name+ 'This Account already exists');
            }
        }
    }
}