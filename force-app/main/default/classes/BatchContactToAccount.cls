global class BatchContactToAccount implements database.Batchable<sObject>{
    
    global database.QueryLocator start(database.BatchableContext BC){
        return database.getQueryLocator('select Id,FirstName,LastName,LeadSource,AccountId from Contact where LeadSource=\'Web\'');
    }
    
    global void execute(database.BatchableContext BC,List<Contact> contactList){
        
        set<Id> accIdSet = new set<Id>();
        if(!contactList.isEmpty()){
            for(Contact objCon : contactList){
                if(objCon.AccountId != null)
                    accIdSet.add(objCon.AccountId);
            }
        }
        
        Map<Id,Account> accMap = new Map<Id,Account>();
        if(!accIdSet.isEmpty()){
            for(Account objAcc : [select Id, Name, Description from Account where Id IN : accIdSet]){
                accMap.put(objAcc.Id,objAcc);
            }
        }
        
        if(!accMap.isEmpty()){
            for(Contact objCon : contactList){
                if(accMap.containsKey(objCon.AccountId)){
                    if(String.isBlank(accMap.get(objCon.AccountId).Description)){
                        accMap.get(objCon.AccountId).Description = objCon.FirstName+' '+objCon.LastName+' '+objCon.LeadSource;
                    }
                    else{
                        accMap.get(objCon.AccountId).Description =accMap.get(objCon.AccountId).Description+ '\n' +objCon.FirstName+' '+objCon.LastName+' '+objCon.LeadSource;
                    }
                }
            }
            Database.update(accMap.values());
        }
    }
    
    global void finish(database.BatchableContext BC){
        
    }
}