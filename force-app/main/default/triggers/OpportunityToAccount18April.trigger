trigger OpportunityToAccount18April on Opportunity (after insert, after update, after delete, after undelete) {
    
    set<Id> accountIdSet = new set<Id>();
    
    if((trigger.isInsert || trigger.isUpdate || trigger.isUndelete) && trigger.isAfter){
        for(Opportunity objOpp : trigger.new){
            if(objOpp.AccountId !=null){
                if((trigger.isInsert || trigger.isUndelete) && trigger.isAfter){
                    accountIdSet.add(objOpp.AccountId);
                }
                if(trigger.isUpdate && trigger.isAfter){
                    If(objOpp.Amount != trigger.oldMap.get(objOpp.Id).Amount || objOpp.Transaction_Type__c != trigger.oldMap.get(objOpp.Id).Transaction_Type__c){
                        accountIdSet.add(objOpp.AccountId);
                    }
                }
            }
        }
    }
    if(trigger.isDelete && trigger.isAfter){
        for(Opportunity objOpp : trigger.old){
            accountIdSet.add(objOpp.AccountId);
        }
    }
    
    
    Map<Id,Account> accMap = new Map<Id,Account>();
    if(!accountIdSet.isEmpty()){
        for(Account objAcc : [select Id, Name, Balance__c from Account where Id IN : accountIdSet]){
            accMap.put(objAcc.Id, objAcc);
        }
    }
    if((trigger.isInsert || trigger.isUpdate || trigger.isUndelete) && trigger.isAfter){
        if(!accMap.isEmpty()){
            for(Opportunity objOpp : trigger.new){
                if(accMap.containsKey(objOpp.AccountId)){
                    if(objOpp.Transaction_Type__c=='Deposit'){
                        accMap.get(objOpp.AccountId).Balance__c =  accMap.get(objOpp.AccountId).Balance__c + objOpp.Amount;
                    }
                    else{
                        if(objOpp.Transaction_Type__c=='Withdraw'){
                            if(accMap.get(objOpp.AccountId).Balance__c >= objOpp.Amount){
                                accMap.get(objOpp.AccountId).Balance__c =  accMap.get(objOpp.AccountId).Balance__c - objOpp.Amount;
                                
                            }
                            else{
                                objOpp.addError('You do not have sufficient balance in your Account');
                            }
                            
                        }
                    }
                }
            }
        }
    }
    if(trigger.isDelete && trigger.isAfter){
        if(!accMap.isEmpty()){
            for(Opportunity objOpp : trigger.old){
                if(accMap.containsKey(objOpp.AccountId)){
                    if(accMap.get(objOpp.AccountId).Balance__c >= objOpp.Amount){
                        accMap.get(objOpp.AccountId).Balance__c =  accMap.get(objOpp.AccountId).Balance__c - objOpp.Amount;
                        
                    }
                    else{
                        objOpp.addError('You do not have sufficient balance in your Account');
                    }
                }
            }
        }
    }
    	
    
    
    List<Account> accListUpdate = new List<Account>();
    accListUpdate.addAll(accMap.values());
    if(!accListUpdate.isEmpty()){
        Database.update(accListUpdate,false);
    }
}