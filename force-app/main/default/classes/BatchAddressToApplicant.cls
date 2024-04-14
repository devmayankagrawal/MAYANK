global class BatchAddressToApplicant implements Database.Batchable<sObject>{
    
    global database.QueryLocator start(Database.BatchableContext BC){
        return database.getQueryLocator('select Id,Name,City__c,Pincode__c,Applicant__c,Applicant__r.Police_Verification__c from Address__c where City__c=\'New Nagpur\' and Pincode__c like \'44%\' and Applicant__r.Police_Verification__c = true');
    }
    
    global void execute(Database.BatchableContext BC,List<Address__c> adrList){
        
        set<Id> applicantIdSet = new set<Id>();
        if(!adrList.isEmpty()){
            for(Address__c objAdr : adrList){
                if(objAdr.Applicant__c != null)
                    applicantIdSet.add(objAdr.Applicant__c);
            }
        }
        
        Map<Id,Applicant__c> applicantMap = new Map<Id,Applicant__c>();
        if(!applicantIdSet.isEmpty()){
            for(Applicant__c objApp : [select Id, List_of_Addresses__c from Applicant__c where Id IN : applicantIdSet]){
                applicantMap.put(objApp.Id,objApp);
            }
        }
        if(!applicantMap.isEmpty()){
            for(Address__c objAdr : adrList){
                if(applicantMap.containsKey(objAdr.Applicant__c)){
                    if(string.isBlank(applicantMap.get(objAdr.Applicant__c).List_of_Addresses__c)){
                        applicantMap.get(objAdr.Applicant__c).List_of_Addresses__c = objAdr.Name+' ' +objAdr.City__c+' '+objAdr.Pincode__c;
                    }
                    else{
                        applicantMap.get(objAdr.Applicant__c).List_of_Addresses__c =applicantMap.get(objAdr.Applicant__c).List_of_Addresses__c+'\n' +objAdr.Name+' ' +objAdr.City__c+' '+objAdr.Pincode__c;
                        
                    }
                }
            }
            Database.update(applicantMap.values(),false);
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}