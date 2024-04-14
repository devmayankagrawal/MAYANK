global class BatchAccountRating implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        system.debug('#Start Method');
        string query = 'select Id,Name,Type,Rating from Account where Type=\'Prospect\'';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accList){
        if(!accList.isEmpty()){
            for(Account objAcc : accList){
                objAcc.Rating='Hot';
            }
            Database.update(accList,False);
        }
    }
    
    global void finish(Database.BatchableContext BC){
        system.debug('#Finish Method');
        
    }
}