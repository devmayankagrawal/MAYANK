global class BatchContact implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id,LeadSource,Level__c from Contact');
    }
    global void execute(Database.BatchableContext BC,List<Contact> conList){
        if(!conList.isEmpty()){
            for(Contact objCon : conList){
                if(objCon.LeadSource=='Web' || objCon.LeadSource=='Phone Inquiry'){
                    objCon.Level__c='Primary';
                }
                else{
                    if(objCon.LeadSource=='Purchased List'){
                        objCon.Level__c='Secondary';
                    }
                    else{
                        objCon.Level__c='Teritary';
                    }
                }
            }
            Database.update(conList,False);
        }
    }
    global void finish(Database.BatchableContext BC){
        
    }
}