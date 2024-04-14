global class BatchCaseCreatedDate implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select Id,Status,CreatedDate from Case where CreatedDate >= 2022-02-15T00:00:00Z and CreatedDate<=2022-04-17T00:00:00Z');
    }
    
   global void execute(Database.BatchableContext BC,List<Case> caseList){
       if(!caseList.isEmpty()){
           for(Case objCase : caseList){
               objCase.Status='Escalated';
           }
           Database.update(caseList,False);
       }
    }
    
   global void finish(Database.BatchableContext BC){
        
    }
    
}