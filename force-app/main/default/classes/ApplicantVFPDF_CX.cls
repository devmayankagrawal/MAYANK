public class ApplicantVFPDF_CX {

public Applicant__c objApp {get; set;}

    public ApplicantVFPDF_CX(ApexPages.StandardController controller) {
    
    string applicantId = ApexPages.CurrentPage().getParameters().get('ID');
    
    system.debug('#Applicant ID='+applicantId);
    
     objApp = [Select ID, First_Name__c, Last_Name__c from Applicant__c where ID=:applicantId];
    
    system.debug('#Applicant Record='+objApp);

    } 

}