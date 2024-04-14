trigger AccountTriggerForAccountHistory on Account (after update) {
    
    List<Account_History__c> accHistoryList = new List<Account_History__c>();
    for(Account objAcc : trigger.old){
        
        string newType = trigger.newMap.get(objAcc.Id).Type;
        If(newType=='Customer - Direct'){
            
            Account_History__c objAccHistory = new Account_History__c(Old_Account_Name__c=objAcc.Name, Old_Type__c=objAcc.Type, Old_Rating__c=objAcc.Rating, Account__c=objAcc.Id);
            accHistoryList.add(objAccHistory);
        }
    }
    
    If(!accHistoryList.isEmpty()){
        insert accHistoryList;
        
    }
    
}