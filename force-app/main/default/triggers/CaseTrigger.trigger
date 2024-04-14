trigger CaseTrigger on Case (before insert, before update) {

    for(Case objCase : trigger.new){
        if(objCase.Status=='New' && objCase.Origin=='Phone'){
            objCase.Product__c='GC1020';
        }
        else{
            if(objCase.Status=='Working' && objCase.Origin=='Web'){
                objCase.Product__c='GC1060';
            }
            else{
                if(objCase.Status=='Escalated' && objCase.Origin=='Email'){
                    objCase.addError('This Case cannot be Escalated');
                }  
                else{
                    objCase.Product__c='';
                }
            }
        }
    }
}