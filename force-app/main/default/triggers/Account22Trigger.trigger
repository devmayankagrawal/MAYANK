trigger Account22Trigger on Account (before insert, before update) {
    
    if(trigger.isInsert && trigger.isBefore){    
        Account22TriggerHandler.beforeInsert(trigger.new);
    }
   
}