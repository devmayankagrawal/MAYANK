public class ApplicantToAddressVF_CX {
      Public List<Applicant__c> applList {get; set;}

    public ApplicantToAddressVF_CX(ApexPages.StandardController controller) {
                 applList = [select Id,Name, First_Name__c, Last_Name__c, Gender__c, Age__c from Applicant__c ];
    

    }

}