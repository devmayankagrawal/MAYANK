public class ApplicantDisclaimer_CX {
             Public Applicant__c objApp {get; set;}
             Public Boolean showNoteFlag {get; set;}
             
    public ApplicantDisclaimer_CX(ApexPages.StandardController controller) {
            string appID = apexPages.currentPage().getParameters().get('ApplicantID');
            
            If(string.isNotBlank(appID)){
            objApp = [select id,Name, First_Name__c, Last_Name__c, Gender__c, Aadhar_Number__c from Applicant__c where ID=:appID];
            
            If(string.isBlank(objApp.Aadhar_Number__c)){
                    showNoteFlag=true;
            }
              else{
                      showNoteFlag=false;
              }
            
            }

    }

}