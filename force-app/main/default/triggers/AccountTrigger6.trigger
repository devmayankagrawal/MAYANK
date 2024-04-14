trigger AccountTrigger6 on Account (before insert,before update) {
    
    if(trigger.isInsert && trigger.isBefore){
        AccountTriggerHandler6.beforeInsert(trigger.new);
    }
}