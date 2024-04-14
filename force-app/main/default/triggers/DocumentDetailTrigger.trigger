trigger DocumentDetailTrigger on Document_Detail__c (before insert, before update, after undelete) {
    
    Map<Id,Document_Detail__c> accIdMap = new Map<Id,Document_Detail__c>();
    
    string documentType = '';
    for(Document_Detail__c objDD : trigger.new){
        if(objDD.Account__c != null){
            accIdMap.put(objDD.Account__c, objDD);
            documentType = accIdMap.get(objDD.Account__c).Document_Type__c;
        }
        
    }
    Map<Id,Document_Detail__c> ddMap = new Map<Id,Document_Detail__c>();
    
    for(Document_Detail__c objDD : [select Id, Document_Type__c, Account__c from Document_Detail__c where Account__c IN : accIdMap.keySet() and Document_Type__c =: documentType]){
        ddMap.put(objDD.Account__c, objDD);
    }
    
    for(Document_Detail__c objDD : trigger.new){
        if(ddMap.containsKey(objDD.Account__c)){
            
            objDD.addError(objDD.Document_Type__c + ' This Document already exists');
        }
        
    }
}