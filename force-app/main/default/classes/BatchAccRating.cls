global class BatchAccRating implements Database.Batchable<sobject>,Database.Stateful {
    
    set<Id> successIdSet = new set<Id>();
    set<Id> failedIdSet = new set<Id>();
    
    global database.QueryLocator start(Database.BatchableContext BC){
        return database.getQueryLocator('select Id,Name,Type,Rating from Account where Rating != \'Cold\'');
    }
    
    global void execute(Database.BatchableContext BC,List<Account> accList){
        if(!accList.isEmpty()){
            for(Account objAcc : accList){
                objAcc.Rating = 'Cold';
            }
            Database.SaveResult[] result = Database.update(accList,False);
            integer index=0;
            
            for( Database.SaveResult sr : result){
                if(sr.isSuccess()){
                    system.debug('Success Record ='+accList[index].Id);
                    successIdSet.add(accList[index].Id);
                    index++;
                }
                else{
                    system.debug('Failed Record ='+accList[index].Id);
                    failedIdSet.add(accList[index].Id);
                    index++;
                }
            }
        }
    }
    global void finish(Database.BatchableContext BC){
        
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();       
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {'agrawalmk10@gmail.com'});
        mail.setSenderDisplayName('Agrawal Industries');
        mail.setSubject('Account Rating Status');
        mail.setPlainTextBody('Success '+successIdSet+'\n'+' Failed ID = '+failedIdSet);
        mailList.add(mail);
        
        if(!mailList.isEmpty()){
            Messaging.sendEmail(mailList);
        }
        
        
    }
}