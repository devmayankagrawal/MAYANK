trigger CustomerTriggerForBackup on Customer__c (before delete) {
    
    List<Customer_History__c> custHistoryList = new List<Customer_History__c>();
    for(Customer__c objCust : trigger.old){
        
        Customer_History__c objCustHistory = new Customer_History__c(Old_FirstName__c = objCust.First_Name__c, Old_Last_Name__c = objCust.Last_Name__c, Old_Gender__c = objCust.Gender__c, Customer__c = objCust.Id);
        custHistoryList.add(objCustHistory);
    }
    if(!custHistoryList.isEmpty()){
        insert custHistoryList;
    }
}