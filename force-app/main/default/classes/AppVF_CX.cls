public class AppVF_CX {

    public  Applicant__c objApplicant {get; set;}

        public AppVF_CX(ApexPages.StandardController controller) {
        
        string applicantId =  ApexPages.currentPage().getParameters().get('Id');
        
        system.debug('#Applicant Id = '+applicantId);
        
         objApplicant = [select Id,First_Name__c,Last_Name__c,Gender__c from Applicant__c where Id=: applicantId];
        system.debug('#Applicant Record=' +objApplicant);
        
        }

}