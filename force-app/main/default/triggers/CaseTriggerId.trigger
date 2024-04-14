trigger CaseTriggerId on Case (before insert,before update,after insert,after update) {
    
    Id userId = [select Id from user where username='XXXXX'].Id;
    
    if((trigger.isBefore && (trigger.isInsert || trigger.isUpdate))){
        for(Case objCase : trigger.new){
            if(objCase.Origin=='Phone'){
                objCase.Status='New';
                objCase.Priority='High';
                ObjCase.OwnerId='userId';
            }
        }
    }
}