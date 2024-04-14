@isTest
public class AppVFTable_CXTest {

    public static testMethod void testApplicantMethod(){
        
        List<Applicant__c> appList = new List<Applicant__c>();
        
        for(integer i=0;i<200;i++){
            Applicant__c objApp = new Applicant__c(First_Name__c='Tanvi'+i,Gender__c='Female');
            appList.add(objApp);
        }
        if(!appList.isEmpty()){
            Database.insert(appList,false);
            
            Applicant__c objApp = new Applicant__c(First_Name__c='Pooja',Gender__c='Female');
            insert objApp;
            
            ApexPages.StandardController controller = new ApexPages.StandardController(objApp);
            
            
            
        }
    }
}