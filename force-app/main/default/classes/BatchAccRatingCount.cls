global class BatchAccRatingCount implements Database.Batchable<sObject>,Database.Stateful{
	
    integer count=0;
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id,Name,Rating from Account where Rating=\'Cold\'');
    }
    global void execute(Database.BatchableContext BC,List<Account>accList){
        
        if(!accList.isEmpty()){
            for(Account objAcc : accList){
                count++;
                
            }
        }
    }
    global void finish(Database.BatchableContext BC){
        system.debug('#Value of Count='+count);
    }
}