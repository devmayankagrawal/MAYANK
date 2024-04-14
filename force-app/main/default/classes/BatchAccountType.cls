global class BatchAccountType implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id,Name,Type,Description from Account');
    }
   global void execute(Database.BatchableContext BC,List<Account> accList){
       if(!accList.isEmpty()){
           for(Account objAcc : accList){
               if(objAcc.Type=='Prospect'){
                   objAcc.Description='Mere pass Bungla Hai, Gadi Hai, Bank Balance Hai, Tere Pass kya Hai?';
               }
               else{
                   if(objAcc.Type=='Customer-Direct'){
                       objAcc.Description='Mere Pass Mask Hai';
                   }
               }
           }
           Database.update(accList,False);
       }
    }
   global void finish(Database.BatchableContext BC){
        
    }
}