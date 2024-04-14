trigger ApplicantTriggerForHistory on Applicant__c (after update) {
    
    List<Applicant_History__c> appHistoryList = new List<Applicant_History__c>();
    for(Applicant__c objApp : trigger.old){
        
        string newGender = trigger.newMap.get(objApp.Id).Gender__c;
        Boolean oldPolVerf = objApp.Police_Verification__c;
        
        If(newGender=='Male' && oldPolVerf==true){
            Applicant_History__c objAppHistory = new Applicant_History__c(Old_Applicant_First_Name__c=objApp.First_Name__c, Old_Applicant_Last_Name__c=objApp.Last_Name__c, Old_Gender__c=objApp.Gender__c, Old_Police_Verification__c= objApp.Police_Verification__c, Applicant__c=objApp.Id);
            appHistoryList.add(objAppHistory);
        }
    }
    If(!appHistoryList.isEmpty()){
        insert appHistoryList;
    }
}