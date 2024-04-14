trigger CaseTriggerForHistory on Case (after update) {
    
    List<Case_History__c> caseHistoryList = new List<Case_History__c>();
    for(Case objCase : trigger.old){
        string newStatus = trigger.newMap.get(objcase.Id).Status;
        string oldOrigin = objCase.Origin;
        
        If(newStatus=='Escalated' && (oldOrigin=='Phone' || oldOrigin=='Email')){
            Case_History__c objCaseHistory = new Case_History__c(Old_Case_Status__c=objCase.Status, Old_Origin__c=objCase.Origin, Case__c=objCase.Id);
            caseHistoryList.add(objCaseHistory);
        }
    }
    if(!caseHistoryList.isEmpty()){
        insert caseHistoryList;
    }
}