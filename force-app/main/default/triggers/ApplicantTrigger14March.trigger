trigger ApplicantTrigger14March on Applicant__c (before insert, after update, before delete) {
    
    List<Messaging.SingleEmailMessage> mailList = new List< Messaging.SingleEmailMessage>();
    
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    if((trigger.isInsert || trigger.isUpdate) && (trigger.isBefore || trigger.isAfter)){
        
        for(Applicant__c objApp : trigger.new){
            if(trigger.isInsert && trigger.isBefore){
                if(objApp.Gender__c=='Male'){
                    objApp.Police_Verification__c=true;
                }
                else{
                    objApp.Police_Verification__c=false;
                }
                
            }
            if(trigger.isUpdate && trigger.isAfter){
                if(objApp.PAN_Card__c != trigger.oldMap.get(objApp.Id).PAN_Card__c){
                    mail.setToAddresses(new String[] {'agrawalmk10@gmail.com'});
                    mail.setSenderDisplayName('Agrawal Industries');
                    mail.setSubject('Pan Card is Updated');
                    mail.setPlainTextBody('Applicant '+ objApp.Name +' Pan Card is updated');
                    mailList.add(mail);
                }
                
            }
        }
    }
    //Delete
    List<Applicant_History__c> appHistoryList = new List<Applicant_History__c>();
    
    if(trigger.isDelete && trigger.isBefore){
        for(Applicant__c objApp : trigger.old){
            Applicant_History__c objAppHistory = new Applicant_History__c(Old_Applicant_First_Name__c=objApp.First_Name__c, Old_Applicant_Last_Name__c=objApp.Last_Name__c, Old_Gender__c=objApp.Gender__c, Old_Police_Verification__c= objApp.Police_Verification__c, Applicant__c=objApp.Id);
            appHistoryList.add(objAppHistory);
            system.debug('#List of Applicants' +appHistoryList);
        }
        
    }
    If(!appHistoryList.isEmpty()){
        insert appHistoryList;
    }
    
    
    
    
    if(!mailList.isEmpty()){
        Messaging.sendEmail(mailList);
    }
    
}