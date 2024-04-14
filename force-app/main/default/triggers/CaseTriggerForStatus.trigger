trigger CaseTriggerForStatus on Case (before insert, before update, after undelete) {
    
    set<Id> accIdSet = new set<Id>();
    For(Case objCase : trigger.new){
        if((trigger.isInsert && trigger.isBefore) || (trigger.isUndelete && trigger.isAfter)){
            if(objCase.AccountId != null){
                accIdSet.add(objCase.AccountId);
            }
        }
        if(trigger.isUpdate && trigger.isBefore){
            if(objCase.Status != trigger.oldMap.get(objCase.Id).Status){
                accIdSet.add(objCase.AccountId);
            }
        }
    }
    Map<Id,Case> caseMap = new Map<Id,Case>();
    If(!accIdSet.isEmpty()){
        for(Case objCase : [select Id, Status, Priority, AccountId from Case where AccountId IN : accIdSet]){
            caseMap.put(objCase.AccountId, objCase);
        }
    }
    
    For(Case objCase : trigger.new){
        if(caseMap.containsKey(objCase.AccountId) && objCase.Status=='Escalated'){
            objCase.addError('This Case with same name status exists!!!...');
        }
        
    }
}