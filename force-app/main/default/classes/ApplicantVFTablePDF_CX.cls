public without sharing class ApplicantVFTablePDF_CX {
                  Public List<Applicant__c> applicantList {get; set;}
                  Public List<Account> accList {get; set;}
                  
    public ApplicantVFTablePDF_CX(ApexPages.StandardController controller) {
    
                    applicantList = ApplicantProvider.getParticularsApplicants(true);
                    getRecord();

    }
    
            Public void getRecord(){
                    accList = [select Name from Account];
            }

}