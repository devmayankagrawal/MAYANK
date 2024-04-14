trigger CaseTrigger15April on Case (before insert, before update) {
    
    set<String> typeNameSet = new set<string>();
    for(Case objCase : trigger.new){
        if(string.isNotBlank(objCase.Type)){
            if(trigger.isInsert && trigger.isBefore){
                typeNameSet.add(objCase.Type);
            }
            If(trigger.isUpdate && trigger.isBefore){
                If(objCase.Type != trigger.oldMap.get(objCase.Id).Type){
                    typeNameSet.add(objCase.Type);
                }
            }
        }
    }
    Map<string,Case> objMap = new Map<string,Case>();
    if(!typeNameSet.isEmpty()){
        for(Case objCase : [select Id, Type from Case where Type IN : typeNameSet]){
            objMap.put(objCase.Type, objCase);
        }
    }
    if(!objMap.isEmpty()){
        for(Case objCase : trigger.new){
            if(objMap.containsKey(objCase.Type)){
                objCase.Type.addError(objCase.Type+ 'This Case Type is already Exists');    
            }
        }
    }
}