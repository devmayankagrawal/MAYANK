public class CaseRequestApi {
    
    public static void getTodayCasesFromAxis(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:AxisBankNamedCred/services/apexrest/v1/getCaseData');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        system.debug('Status Code ='+response.getStatusCode());
        system.debug('Response Body ='+response.getBody());
        
        if(response.getStatusCode() == 200){
            List<Object> objList = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Case> caseList = new List<Case>();
            
            for(Object obj : objList){
                Map<string,Object> caseMap = (Map<String,Object>)obj;
                system.debug('Case Number ='+caseMap.get('CaseNumber'));
                system.debug('Status ='+caseMap.get('Status'));
                system.debug('Priority ='+caseMap.get('Priority'));
                
                Case objCase = new Case(Status=String.valueOf(caseMap.get('Status')), Priority=String.valueOf(caseMap.get('Priority')));
                caseList.add(objCase);
            }
            if(!caseList.isEmpty()){
                Database.insert(caseList,false);
            }
        }
    }
    
}