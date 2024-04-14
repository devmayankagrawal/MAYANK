trigger AccountTriggerToContactPhone on Account (after update) {

    Map<Id,Account> accMap = new Map<Id,Account>();
    for(Account objAcc : trigger.new){
        if(objAcc.Phone != trigger.oldMap.get(objAcc.Id).Phone){
            accMap.put(objAcc.Id, objAcc);
        }
    }
    system.debug('Step 1 Map Data='+accMap);
    
    List<Contact> conList = new List<Contact>();
    if(!accMap.isEmpty()){
        for(Contact objCon : [select Id, Phone, AccountId from Contact where AccountId IN : accMap.keySet()]){
            conList.add(objCon);
        }
    }
    system.debug('Step 2 Contact data='+conList);
    
    if(!conList.isEmpty()){
        System.debug('Step  3 Inside of checker');
        for(Contact objCon : conList){
            if(accMap.containsKey(objCon.AccountId)){
                System.debug('Step  3 Inside of contains Key');
                accMap.get(objCon.AccountId).Phone = objCon.Phone;
                System.debug('Step  3 phone data');
            }
        }
        Database.update(conList,false);
    }
}