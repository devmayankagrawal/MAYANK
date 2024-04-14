public with sharing class AppVFTablePDF_CX {

            public List<Applicant__c> appList {get;set;}
            public List<Account> accList {get;set;}
    
    public AppVFTablePDF_CX(ApexPages.StandardController controller) {
    
             appList = ApplicantProvider.getParticularsApplicants(true);
             getRecord();

    }
            public void getRecord(){
                 accList = [select ID,Name from Account];
                 
            }

}