global class BatchApplicantMail implements database.Batchable<sObject>{
    
    global database.QueryLocator start(Database.BatchableContext BC){
        return database.getQueryLocator('select Id,First_Name__c,Gender__c,Police_Verification__c,Email_ID__c from Applicant__c where Police_Verification__c=true and Email_ID__c != null');
    }
    
    global void execute(Database.BatchableContext BC,List<Applicant__c> appList){
        
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        
        if(!appList.isEmpty()){
            for(Applicant__c objApp : appList){               
                
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {objApp.Email_Id__c});
                mail.setSenderDisplayName('Agrawal industries');
                mail.setSubject('Call for Remand');
                mail.setPlainTextBody('Hi '+objApp.First_Name__c+ ', \n Visit to Nearest Police Station. \n\n Thanks and Regards \n Nation Visa');
                
                
                
            }
            
            if(!mailList.isEmpty()){
                Messaging.SendEmailResult[] results = Messaging.sendEmail(mailList);
                
            }
            
            
        }
        
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}