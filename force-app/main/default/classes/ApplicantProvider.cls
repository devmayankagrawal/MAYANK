public with sharing class ApplicantProvider {
    
    Public static List<Applicant__c> getAllApplicants(){
        List<Applicant__c> appList = [select Id, Name, First_Name__c, Last_Name__c, Gender__c, CreatedBy.Name from Applicant__C WITH SECURITY_ENFORCED];
        return appList;
        
    }
    
    Public static List<Applicant__c> getParticularsApplicants(Boolean policeVerification){
        List<Applicant__c> appList = [select Id, Name, First_Name__c, Last_Name__c, Gender__c, CreatedBy.Name, Police_Verification__c
                                      from Applicant__c where Police_Verification__c=: policeVerification WITH SECURITY_ENFORCED];
        return appList;
    }
            @AuraEnabled
            public static string createApplicantRecord(Applicant__c objApplicant){
                try {
                    insert objApplicant;
                    return 'Record Created Successfully!!!..';
                    
                } catch (Exception e) {
                    throw new AuraHandledException(e.getMessage());
                }
            }
                
            @AuraEnabled
            public static List<Address__c> searchAddresses(String appName){
                try {
                        ID appID15 = [select id from Applicant__c where Name= : appName].id;
                        return ([select ID, Name, Country__c, State__c, City__c from Address__c where Applicant__c= :appID15]);

                } catch (Exception e) {
                    throw new AuraHandledException(e.getMessage());
                }
            }
                @AuraEnabled
                public static string deleteAddresses(List<Id> adrIDList){
                    try {
                            if(!adrIDList.isEmpty()){
                                Database.delete ([select id from Address__c where ID IN : adrIDList],false);
                                return 'Records Deleted';
                            }
                                else {
                                    return 'Empty Records';
                                }
                        
                    } catch (Exception e) {
                        throw new AuraHandledException(e.getMessage());
                    }
                }
                @AuraEnabled
                public static List<Address__c> newSearchAddresses(Applicant__c objApp){
                    try {
                            ID appID15 = [select id from Applicant__c where Name= : objApp.Name].id;
                            return ([select ID, Name, Country__c, State__c, City__c,Applicant__c from Address__c where Applicant__c= :appID15]);
    
                    } catch (Exception e) {
                        throw new AuraHandledException(e.getMessage());
                    }
                }
    
    @AuraEnabled
    public static Applicant__c searchApplicant(Applicant__c objApp){
        try {
            if(objApp != null){
                return ([select Id, Name,First_Name__c,Last_Name__c,Gender__c,Police_Verification__c  from Applicant__c where Name=: objApp.Name LIMIT 1] );
            }
            else{
                return null;
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
}