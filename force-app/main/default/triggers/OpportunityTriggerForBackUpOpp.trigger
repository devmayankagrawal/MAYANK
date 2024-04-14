trigger OpportunityTriggerForBackUpOpp on Opportunity (before delete) {
    
    List<Opportunity_Backup__c> oppBackupList = new List<Opportunity_Backup__c>();
    
    for(Opportunity objOpp : trigger.old){
        if(objOpp.StageName == 'Prospecting'){
            objOpp.addError('This opp can not be deleted, because of Stage Prospecting');
        }
        else{
            Opportunity_Backup__c objOppBackup = new Opportunity_Backup__c(Opp_Name__c = objOpp.Name, Opp_Stage__c = objOpp.StageName);
            oppBackupList.add(objOppBackup);
        }
    }
    
    if(!oppBackupList.isEmpty()) 
        Database.insert(oppBackupList, false);
}