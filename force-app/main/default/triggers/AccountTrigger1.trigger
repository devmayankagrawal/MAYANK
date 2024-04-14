trigger AccountTrigger1 on Account (before insert, before update) {

    for(Account objAcc : trigger.new){
        
        If(objAcc.SLA__c=='Gold'){
            objAcc.Description='olalala';
        }
        else{
            if(objAcc.SLA__c=='Silver'){
                objAcc.Description='Yahoooo';
            }
            else{
                objAcc.Description='';
            }
        }
    }
}