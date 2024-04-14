public class AddrTableVF_CX {
    
    public  List<Address__c> adrList {get;set;}
    
    public AddrTableVF_CX(ApexPages.StandardController controller) {
    
        string appId = ApexPages.currentPage().getParameters().get('ApplicantId');
        
        if(string.isNotBlank(appId)){
        adrList =  [select Id,Address_Line_1__c,Country__c,State__c,City__c,Applicant__c,Applicant_Full_Name__c,Applicant__r.Police_Verification__c from Address__c where Applicant__c=: appId];
        system.debug('#Address Records'+adrList);
       }
           else{
                   system.debug('#Applicant ID is Blank');
           }     
    }

}