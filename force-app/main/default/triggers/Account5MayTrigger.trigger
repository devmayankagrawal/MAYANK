trigger Account5MayTrigger on Account (before insert,before update) {
    
    if(trigger.isInsert && trigger.isBefore){    
        Account5MayTriggerHandler.beforeInsert(trigger.new);
    }
}