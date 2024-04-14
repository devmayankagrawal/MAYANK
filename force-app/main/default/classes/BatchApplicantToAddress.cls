global class BatchApplicantToAddress implements Database.Batchable<sObject>{
    
    global database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id,Gender__c,Police_Verification__c from Applicant__c');
    }
    
    global void execute(Database.BatchableContext BC,List<Applicant__c> appList){
        
        Map<Id,Applicant__c> appMap = new Map<Id,Applicant__c>();
        
        if(!appList.isEmpty()){
            for(Applicant__c objApp : appList){
                appMap.put(objApp.Id,objApp);
            }
        }
        
        List<Address__c> adrList = new List<Address__c>();
        if(!appMap.isEmpty()){
            for(Address__c objAdr : [select Id,Country__c,State__c,City__c,Applicant__c from Address__c where Applicant__c IN : appMap.keySet()]){
                adrList.add(objAdr);
            }
        }
        if(!adrList.isEmpty()){
            for(Address__c objAdr : adrList){
                if(appMap.containsKey(objAdr.Applicant__c)){
                    if(appMap.get(objAdr.Applicant__c).Police_Verification__c=true){
                        if(appMap.get(objAdr.Applicant__c).Gender__c=='Male'){
                            objAdr.Country__c='India';
                            objAdr.State__c='Maharashtra';
                            objAdr.City__c='New Nagpur';
                        }
                        else{
                            objAdr.Country__c='India';
                            objAdr.State__c='Maharashtra';
                            objAdr.City__c='Pune';
                        }
                    }
                    else{
                        if(appMap.get(objAdr.Applicant__c).Police_Verification__c && appMap.get(objAdr.Applicant__c).Gender__c=='Female'){
                            objAdr.Country__c='India';
                            objAdr.State__c='Gujrat';
                            objAdr.City__c='Surat';
                        }
                        else{
                             objAdr.Country__c='India';
                            objAdr.State__c='Gujrat';
                            objAdr.City__c='Ahmedabad';
                        }
                        
                    }
                }
            }
            Database.update(adrList,False);
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
    
}