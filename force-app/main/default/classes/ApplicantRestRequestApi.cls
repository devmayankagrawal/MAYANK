public class ApplicantRestRequestApi {
    
    public static void getAllApplicantsFromAxis(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:AxisBankNamedCred/services/apexrest/v1/getApplicantData');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        system.debug('Status Code ='+response.getStatusCode());
        system.debug('Response Body ='+response.getBody());
        
        if(response.getStatusCode() == 200){
            List<Object> objList = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Applicant__c> appList = new List<Applicant__c>();
            
            for(Object obj : objList){
                Map<string,Object> applicantMap = (Map<String,Object>)obj;
                system.debug('First Name ='+applicantMap.get('First_Name__c'));
                system.debug('Last Name ='+applicantMap.get('Last_Name__c'));
                system.debug('Gender ='+applicantMap.get('Gender__c'));
                
                Applicant__c objApp = new Applicant__c(First_Name__c=String.valueOf(applicantMap.get('First_Name__c')), Last_Name__c=String.valueOf(applicantMap.get('Last_Name__c')), Gender__c=String.valueOf(applicantMap.get('Gender__c')));
                appList.add(objApp);
            }
            if(!appList.isEmpty()){
                Database.insert(appList,false);
            }
        }
    }
    public static void getAllMaleApplicants(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:AxisBankNamedCred/services/apexrest/v1/getApplicantData?gender=Male&age=18');
        request.setMethod('GET');
        HttpResponse response =  http.send(request);
        
        System.debug('Status Code = '+response.getStatusCode());
        System.debug('Status Code = '+response.getBody());
        
        
        if(response.getStatusCode() == 200){
            
            List<Object> objList = (List<Object>) JSON.deserializeUntyped(response.getBody());
            
            for(Object obj : objList){
                Map<String,Object> appMap  = (Map<String,Object>) obj;
                System.debug('Received First Name = '+appMap.get('First_Name__c') );  
            } 
        }       
    }
    public static void getUpdateApplicantsFromAxis(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:AxisBankNamedCred/services/apexrest/v1/getApplicantData');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        request.setBody('{"firstName":"Tanvi" , "lastName" : "Mehra" , "gender" : "Female"}');        
        
        HttpResponse response =  http.send(request);
        
        System.debug('Status Code = '+response.getStatusCode());
        System.debug('Response Body = '+response.getBody());
        
        if(response.getStatusCode() == 200){
            Map<String, Object> appMap = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());//Single Object Record
            
            System.debug('Received Reponse = '+appMap.get('First_Name__c'));  
            System.debug('Received Reponse = '+appMap.get('Last_Name__c'));  
            System.debug('Received Reponse = '+appMap.get('Gender__c'));  
            System.debug('Received Reponse = '+appMap.get('Id')); 
        }
    }
    
    public static void getDeleteApplicantsFromAxis(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:AxisBankNamedCred/services/apexrest/v1/getApplicantData');
        request.setMethod('DELETE');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        request.setBody('{"firstName":"Tanvi" }');
        
        
        HttpResponse response =  http.send(request);
        
        System.debug('Status Code = '+response.getStatusCode());
        
        
        if(response.getStatusCode() == 200){
            
            System.debug('Response Body = '+response.getBody());
        }       
        
    }
    
    
}