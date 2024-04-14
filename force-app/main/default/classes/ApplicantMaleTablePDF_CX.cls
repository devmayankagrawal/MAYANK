public class ApplicantMaleTablePDF_CX {
   Public List<Applicant__c> appList {get; set;}

    public ApplicantMaleTablePDF_CX(ApexPages.StandardController controller) {
    
   appList= [select id, First_Name__c, Last_Name__c, Gender__c from Applicant__c where Gender__c='Male' Limit 10];
   system.debug('#Applicant Records='+appList);

    }

}