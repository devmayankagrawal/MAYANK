global class BatchCaseStatusEscalated implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator('Select Id,CaseNumber,Priority,Status,Origin from Case where Origin=\'Web\' and Priority=\'High\'');
    }
    
    global void execute(Database.BatchableContext BC, List<Case> caseList){
        if(!caseList.isEmpty()){
            for(Case objCase : caseList){
                objCase.Status='Escalated';
            }
            Database.update(caseList,False);
        }
        
    }
    
    global void finish(Database.BatchableContext BC){
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {'agrawalmk10@gmail.com'});
        mail.setSenderDisplayName('Agrawal Industries');
        mail.setSubject('Batch Class Completed');
        mail.setPlainTextBody('Case Status Escalated ');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        
        
        
    }
}