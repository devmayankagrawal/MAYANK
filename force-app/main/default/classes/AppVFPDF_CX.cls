public class AppVFPDF_CX {

            public  Applicant__c objApp {get;set;}
            public Boolean showNoteFlag {get;set;}

    public AppVFPDF_CX(ApexPages.StandardController controller) {
    
            string appId = ApexPages.currentPage().getParameters().get('ApplicantId');
            
                if(string.isNotBlank(appId)){
               objApp  = [select Id,Name,First_Name__c,Last_Name__c,Gender__c,Aadhar_Number__c from Applicant__c where Id=:appId];
                    system.debug('#Applicant Records='+objApp);
                    if(string.isBlank(objApp.Aadhar_Number__c)){
                        showNoteFlag=true;
                    }
                        else{
                            showNoteFlag=false;
                        }
            }
    }

}