trigger AccountTriggerSharing on Account (after insert, after update) {
    
    List<AccountShare> accShareList = new List<AccountShare>();
    for(Account objAcc : trigger.new){
        if(trigger.isInsert && trigger.isAfter){
            AccountShare accShare = new AccountShare(); // STEP 1 Instance
            accShare.AccountId = objAcc.Id; //STEP 2 Record Id
            accShare.UserOrGroupId = objAcc.User__c; //Step 3 User Id
            accShare.AccountAccessLevel = 'Read'; //or Edit
            accShare.CaseAccessLevel = 'Read';
            accShare.OpportunityAccessLevel = 'Read';        
            accShareList.add(accShare);
        }
        if(trigger.isUpdate && trigger.isAfter){
            AccountShare accShare = new AccountShare(); // STEP 1 Instance
            accShare.AccountId = objAcc.Id; //STEP 2 Record Id
            accShare.UserOrGroupId = objAcc.User__c; //Step 3 User Id
            accShare.AccountAccessLevel = 'Read'; //or Edit
            accShare.CaseAccessLevel = 'Read';
            accShare.OpportunityAccessLevel = 'Read';        
            accShareList.add(accShare);
        }
    }
    if(!accShareList.isEmpty()){
        Database.insert(accShareList,false);
    }
}