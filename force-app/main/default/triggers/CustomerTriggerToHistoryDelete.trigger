trigger CustomerTriggerToHistoryDelete on Customer__c (before delete) {
    
    List<Id> custHistoryList = new List<Id>();
    for(Customer__c objCust : trigger.old){
        custHistoryList.add(objCust.Id);
    }
    Customer_History__c[] objCustHistory = [select Id from Customer_History__c where Customer__c IN : custHistoryList];
    delete objCustHistory;

}