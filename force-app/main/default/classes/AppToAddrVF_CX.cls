public class AppToAddrVF_CX {

        public List<Applicant__c> appList {get;set;}

    public AppToAddrVF_CX(ApexPages.StandardController controller) {
    
            string appName = ApexPages.currentPage().getParameters().get('ApplicantName');
            
                if(string.isNotBlank(appName)){
            appList = [select Id,Name,First_Name__c,Last_Name__c,Gender__c,(select Id,Address_Line_1__c,Country__c,State__c,City__c from Addresses__r) from Applicant__c where Name=:appName];
            system.debug('#Applicant List='+appList);
        }
        else{
                system.debug('#Applicant name should not be blank');
        }
    }

}