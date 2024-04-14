public class ApplicantToAddressVFTablePDF_CX {
    Public List<Applicant__c> applicantList {get; set;}

    public ApplicantToAddressVFTablePDF_CX(ApexPages.StandardController controller) {
         applicantList = [select Id, Name, First_Name__c, Last_Name__c, Gender__c, Age__c,(select id,Country__c, State__c, City__c from Addresses__r) from Applicant__c Limit 5];

    }

}