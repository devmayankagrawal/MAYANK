public class AppVFTable_CX {

            Public List<Applicant__c> applicantList {get; set;}
    
    public AppVFTable_CX(ApexPages.StandardController controller) {
            
           string appGender = ApexPages.currentPage().getParameters().get('ApplicantGender'); 
           
           if(string.isNotBlank(appGender)){ 
          applicantList =   [select Id,First_Name__c,Last_Name__c,Gender__c from Applicant__c where Gender__c=: appGender Limit 10];
         
         system.debug('#Total Records='+applicantList);
        }
                        else{
                                    system.debug('#Applicant gender should not be blank');
                        }
    }

}