trigger AccountTrigger15April on Account (before insert, before update) {
    set<string> accNameSet = new set<string>();
    for(Account objAcc : trigger.new){
        if(trigger.isInsert && trigger.isBefore){
            accNameSet.add(objAcc.Name);
        }
        if(trigger.isUpdate && trigger.isBefore){
            if(objAcc.Name != trigger.oldMap.get(objAcc.Id).Name){
                accNameSet.add(objAcc.Name);
            }
        }
        
    }
        delete([select Id, Name from Account where Name IN : accNameSet]);
}