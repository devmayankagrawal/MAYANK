global class BatchAccountCount implements Database.Batchable<sObject>,Database.Stateful {

    set<Id> successIdSet = new set<Id>();
    set<Id> failureIdSet = new set<Id>();
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id,Type,Rating from Account where Rating=\'Cold\'');
    }
    global void execute(Database.BatchableContext BC,List<Account> accList){
        
        if(!accList.isEmpty()){
            for(Account objAcc : accList){
                objAcc.Type='Prospect';
            }
            Database.SaveResult[]result = Database.update(accList,False);
            integer index=0;
            
            for(Database.SaveResult sr : result){
                if(sr.isSuccess()){
                    system.debug('#Success record='+accList[index].Id);
                    successIdSet.add(accList[index].Id);
                    index++;
                }
                else{
                    system.debug('#Failed record='+accList[index].Id);
                    failureIdSet.add(accList[index].Id);
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
            mail.setSubject('Account Type');
            mail.setPlainTextBody('Success '+successIDSet+'\n'+' Failed ID = '+failureIDSet);
            mailList.add(mail);
       
    if(!mailList.isEmpty()){
        Messaging.sendEmail(mailList);
    }

        
    }
}