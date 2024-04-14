public class AddressTablePDF_CX {
                    Public List<Address__c> adrList {get; set;}
                
                    public AddressTablePDF_CX(ApexPages.StandardController controller) {
                    string appID = ApexPages.CurrentPage().getParameters().get('ApplicantID');
                    if(string.isNotBlank(appID)){
                       adrList= [select ID, Address_Line_1__c, Address_Line_2__c, Country__c, State__c, City__c, Applicant__c, Applicant_Full_Name__c, Applicant__r.Gender__c, Applicant__r.Age__c from Address__c where
                                              Applicant__c =: appID ];
                                              system.debug('#Addres List='+adrList);
                                              
                                           }
                                           else{
                                           system.debug('Applicant id is blank');
                                           }
                
    }

}