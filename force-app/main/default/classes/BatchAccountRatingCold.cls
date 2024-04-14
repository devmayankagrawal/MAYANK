global class BatchAccountRatingCold implements Database.Batchable<sObject>,Database.Stateful{
    
    public set<Id> successIDSet  = new set<Id>();
    public set<Id> failureIDSet  = new set<Id>();
    
    global database.QueryLocator start(Database.BatchableContext BC){
        return database.getQueryLocator('select Id,Name,Type,Rating from Account where Rating=\'Cold\'');
    }
    
    global void execute(Database.BatchableContext BC,List<Account> accList){
        if(!accList.isEmpty()){
            for(Account objAcc : accList){
                objAcc.Type='Prospect';
            }
            Database.SaveResult[] result = Database.update(accList,False);
            Integer index=0;
            
            for(Database.SaveResult sr : result){// 2/4
                if(sr.isSuccess()){
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('#Successfully Updated Account ID: ' + accList[index].Id);
                    
                    successIDSet.add(accList[index].Id);
                    
                    index++;
                }
                else{
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                        
                        System.debug('@Failed Account Id = '+accList[index].Id );                           
                        
                        failureIDSet.add(accList[index].Id);
                        
                        index++;
                    }
                }
            }
            
        }
    }
    
    global void finish (Database.BatchableContext BC){
        
        System.debug('#Success Records = ' +successIDSet.size());
        System.debug('#Failed Records = '+failureIDSet.size()); 
        
        
        if(!successIDSet.isEmpty()){
            for(ID successID : successIDSet){
                System.debug('#Sucess ID = '+successID);
            }
        } 
        
        
        if(!failureIDSet.isEmpty()){
            for(ID failureID : failureIDSet){
                System.debug('#Failed ID = '+failureID);
            }
        } 
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {'agrawalmk10@gmail.com'});
        mail.setSenderDisplayName('Agrawal Industries');
        mail.setSubject('Kundali');
        mail.setPlainTextBody('Hi,Success'+successIDSet +' \n failed ='+failureIDSet);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        
    }
}