trigger AccountTrigger5June on Account (before insert, before update) {
    
    if(trigger.isInsert && trigger.isBefore){
        AccountTriggerHandler6June.beforeInsert(trigger.new);
    }
    
    if(trigger.isUpdate && trigger.isBefore){
        AccountTriggerHandler6June.beforeUpdate(trigger.new,trigger.oldMap);
    }
}