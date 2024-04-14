trigger AccountTriggerToContactType on Account (after update) {
    
    Map<Id,Account> accMap = new Map<ID,Account>();
    for(Account objAcc : trigger.new){
        if(objAcc.Type != trigger.oldMap.get(objAcc.Id).Type){
            accMap.put(objAcc.Id, objAcc);
        }
    }
    List<Contact> contactList = new List<Contact>();
    if(!accMap.isEmpty()){
        for(Contact objCon : [select Id, Level__c, LeadSource, AccountId from Contact where AccountId IN : accMap.keySet()]){
            contactList.add(objCon);    
        }
    }
    if(!contactList.isEmpty()){
        for(Contact objCon : contactList){
            if(accMap.containsKey(objCon.AccountId)){
                if(accMap.get(objCon.AccountId).Type=='Technology Partner'){
                    objCon.LeadSource = 'Web';
                    objCon.Level__c = 'Primary';
                }
                else{
                    objCon.LeadSource = '';
                    objCon.Level__c = '';
                }
            }
        }
        Database.update(contactList,False);
    }
}