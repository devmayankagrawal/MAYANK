trigger OpportunityTriggerForBackUp on Opportunity (before delete) {
    
    List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
    for(Opportunity objOpp : trigger.old){
        if(objOpp.Amount>=18000 && objOpp.CloseDate.month()==8 && (objOpp.StageName=='Prospecting' || objOpp.StageName=='Closed Lost')){
            objOpp.addError('This Opportunity cannot be deleted');
        }
        else{
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] {'agrawalmk10@gmail.com'});
            mail.setSenderDisplayName('Agrawal Industries');
            mail.setSubject('Your Opp record has been deleted');
            mail.setPlainTextBody('Recently, an Opportinty '+ objOpp.Name +'\n Record has been deleted ');
           mailList.add(mail);
            
        }
    }
    If(!mailList.isEmpty()){
        Messaging.sendEmail(mailList);
    }
}