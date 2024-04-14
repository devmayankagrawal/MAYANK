trigger ApplicantTriggerTask on Applicant__c (after insert) {
    
    List<Task> taskList = new List<Task>();
    
    for(Applicant__c objApp : trigger.new){
        Task tsk = new Task();
        tsk.Subject = objApp.First_Name__c+' Task';
        tsk.WhatId = objApp.Id;
        tsk.OwnerId = UserInfo.getUserId();
        tsk.Status = 'Completed';
        tsk.Priority = 'High';
        taskList.add(tsk);
        
    }
    
    if(!taskList.isEmpty())
        Database.insert(taskList,false);
    
}