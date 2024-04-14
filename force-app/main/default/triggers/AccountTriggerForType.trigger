trigger AccountTriggerForType on Account (before insert, before update) {
    
    
    for(Account objAcc : trigger.new){
        if(string.isNotBlank(objAcc.Type) && objAcc.Type=='Prospect'){
            if(trigger.isInsert && trigger.isBefore){
                objAcc.Rating = 'Hot';
            }
            if(trigger.isUpdate && trigger.isBefore){
                if(objAcc.Type != trigger.oldMap.get(objAcc.Id).Type){
                    objAcc.Rating = 'Hot';
                }
            }
        }
        else{
            objAcc.Rating = '';
        }
    }
}