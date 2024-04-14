trigger AccountTrigger14April on Account (after insert, after update, after delete) {
    
    List<Messaging.SingleEmailMessage> mailList = new List< Messaging.SingleEmailMessage>();
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
    if((trigger.isInsert || trigger.isUpdate) && trigger.isAfter){
        for(Account objAcc : trigger.new){
            
            //Insert
            if(trigger.isInsert && trigger.isAfter){
                mail.setToAddresses(new String[] {'agrawalmk10@gmail.com'});
                mail.setSenderDisplayName('Agrawal Industries');
                mail.setSubject('Account Createdd');
                mail.setPlainTextBody('Your Account '+ objAcc.Name +' is Created');
                mailList.add(mail);
            }
            //Update
            if(trigger.isUpdate && trigger.isAfter){
                if((objAcc.Rating != trigger.oldMap.get(objAcc.Id).Rating)){
                    if(objAcc.Rating=='Cold' && trigger.oldMap.get(objAcc.Id).Rating=='Hot'){
                        mail.setToAddresses(new String[] {'agrawalmk10@gmail.com'});
                        mail.setSenderDisplayName('Agrawal Industries');
                        mail.setSubject('Account is Updated');
                        mail.setPlainTextBody('Your Account '+ objAcc.Name +' Rating is Updated fom Hot to Cold');
                        mailList.add(mail);
                    }
                }
            }
        }
    }
    //Delete
    if(trigger.isDelete && trigger.isAfter){
        for(Account objAcc : trigger.old){
            mail.setToAddresses(new String[] {'agrawalmk10@gmail.com'});
            mail.setSenderDisplayName('Agrawal Industries');
            mail.setSubject('Account is Deleted');
            mail.setPlainTextBody('Your Account '+ objAcc.Name +' is Deleted');
            mailList.add(mail);
        }
    }
    
    
    
    if(!mailList.isEmpty()){
        Messaging.sendEmail(mailList);
    }
}