trigger OpportunityTrigger15April on Opportunity (before insert, before update) {

    set<string> oppNameSet = new set<string>(); 
    for(Opportunity objOpp : trigger.new){
        if(string.isNotBlank(objOpp.Name)){
            If(trigger.isInsert && trigger.isBefore){
                oppNameSet.add(objOpp.Name);
            }
            if(trigger.isUpdate && trigger.isBefore){
                If(objOpp.Name != trigger.oldMap.get(objOpp.Id).Name){
                    oppNameSet.add(objOpp.Name);
                }
            }
        }
    }
        Map<string,Opportunity> oppMap = new Map<string,Opportunity>();
    if(!oppNameSet.isEmpty()){
        for(Opportunity objOpp : [select Id, Name from Opportunity where Name IN : oppNameSet]){
            oppMap.put(objOpp.Name, objOpp);
        }
    }
    if(!oppMap.isEmpty()){
        for(Opportunity objOpp : trigger.new){
            if(oppMap.containsKey(objOpp.Name)){
                objOpp.Name.addError(objOpp.Name+ 'This Opportunity is already exists...!!!');
            }
        }
    }
}