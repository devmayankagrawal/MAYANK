trigger TransactionTriggerToCustomer on Transaction__c (after insert, after update, after delete, after undelete) {
    
    set<Id> custIDSet = new set<Id>();
    
    if((trigger.isInsert || trigger.isUpdate || trigger.isUndelete) && trigger.isAfter){
        for(Transaction__c objTrans : trigger.new){
            if(objTrans.Customer__c !=null){
                if((trigger.isInsert || trigger.isUndelete) && trigger.isAfter){
                    custIDSet.add(objTrans.Customer__c);
                }
                if(trigger.isUpdate && trigger.isAfter){
                    if(objTrans.Transaction_Type__c != trigger.oldMap.get(objTrans.Id).Transaction_Type__c || objTrans.Amount__c !=trigger.oldMap.get(objTrans.Id).Amount__c ){
                        custIDSet.add(objTrans.Customer__c);
                    }
                }
            }
        }
    }
    if(trigger.isDelete && trigger.isAfter){
        for(Transaction__c objTrans : trigger.old){
            custIDSet.add(objTrans.Customer__c);
        }
    }
    Map<Id,Customer__c> custMap = new Map<Id,Customer__c>();
    if(!custIDSet.isEmpty()){
        for(Customer__c objCust : [select Id, Total_Balance__c from Customer__c where Id IN : custIDSet]){
            custMap.put(objCust.Id, objCust);
        }
    }
    if((trigger.isInsert || trigger.isUpdate || trigger.isUndelete) && trigger.isAfter){
        if(!custMap.isEmpty()){
            for(Transaction__c objTrans : trigger.new){
                if(custMap.containsKey(objTrans.Customer__c)){
                    if(objTrans.Transaction_Type__c=='Deposit'){
                        custMap.get(objTrans.Customer__c).Total_Balance__c = custMap.get(objTrans.Customer__c).Total_Balance__c + objTrans.Amount__c;
                    }
                    else{
                        if(objTrans.Transaction_Type__c=='Withdraw'){
                            if(custMap.get(objTrans.Customer__c).Total_Balance__c >= objTrans.Amount__c){
                                custMap.get(objTrans.Customer__c).Total_Balance__c = custMap.get(objTrans.Customer__c).Total_Balance__c - objTrans.Amount__c;
                                
                            }
                            else{
                                objTrans.addError('You do not have sufficient balance in your Account');
                            }
                        }
                    }
                }
            }
        }
    }
    if(trigger.isDelete && trigger.isAfter){
        if(!custMap.isEmpty()){
            for(Transaction__c objTrans : trigger.old){
                if(custMap.containsKey(objTrans.Customer__c)){
                    if(custMap.get(objTrans.Customer__c).Total_Balance__c >= objTrans.Amount__c){
                        custMap.get(objTrans.Customer__c).Total_Balance__c = custMap.get(objTrans.Customer__c).Total_Balance__c - objTrans.Amount__c;
                        
                    }
                    else{
                        objTrans.addError('You do not have sufficient balance in your Account');
                    }
                }
            }
        }
    }
    List<Customer__c> custListUpdate = new List<Customer__c>();
    custListUpdate.addAll(custMap.values());
    
    if(!custListUpdate.isEmpty()){
        Database.update(custListUpdate, false);
    }
    
    
}