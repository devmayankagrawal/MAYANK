global class BatchAccountToContact implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id,Name,Type from Account');
    }
    
    global void execute(Database.BatchableContext BC,List<Account> accList){
        
        Map<Id,Account> accMap = new Map<Id,Account>();
        if(!accList.isEmpty()){
            for(Account objAcc : accList)
                accMap.put(objAcc.Id, objAcc);
        }
        
        List<Contact> contactList = new List<Contact>();
        if(!accMap.isEmpty()){
            for(Contact objCon : [select Id,Level__c,AccountId from Contact where AccountId IN : accMap.keySet()]){
                contactList.add(objCon);
            }
        }
        
        if(!contactList.isEmpty()){
            for(Contact objCon : contactList){
                if(accMap.containsKey(objCon.AccountId)){
                    if(accMap.get(objCon.AccountId).Type=='Prospect'){
                        objCon.Level__c='Primary';
                    }
                    else{
                        if(accMap.get(objCon.AccountId).Type=='Customer - Direct'){
                            objCon.Level__c='Secondary';
                        }
                        else{
                            if(accMap.get(objCon.AccountId).Type=='	Technology Partner'){
                                objCon.Level__c='Tertiary';
                            }
                            else{
                                objCon.Level__c='';
                            }
                        }
                    }
                }
            }
           Database.SaveResult[]result = Database.update(contactList,false);
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}