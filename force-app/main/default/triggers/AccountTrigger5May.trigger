trigger AccountTrigger5May on Account (before insert,before update) {
    
    if(trigger.isInsert && trigger.isBefore){
        AccountTrigger5MayHandler.beforeInsert(trigger.new);
           
    }
    
     if(trigger.isUpdate && trigger.isBefore){
        AccountTrigger5MayHandler.beforeUpdate(trigger.new,Trigger.oldMap);
    }
}