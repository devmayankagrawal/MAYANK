global class BatchCaseStatusToday implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id,CaseNumber,Status,Origin,Priority from Case where CreatedDate=Today');
    }
   global void execute(Database.BatchableContext BC,List<case> caseList){
        if(!caseList.isEmpty()){
            for(Case objCase : caseList){
                if(objCase.Origin=='Web' && objCase.Priority=='High'){
                    objCase.Status='Escalated';
                }
            }
            	Database.update(caseList,False);
        }
    }
   global void finish(Database.BatchableContext BC){
        
    }
}