public class SourceProgram {

    public static void getTargetAccountData(){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:AxisBankNamedCred/services/apexrest/getAllAccountData');
        
        request.setMethod('GET');
        
        Http http =new Http();
        HttpResponse response = http.send(request);
        system.debug('Received Response Data ='+response.getBody());
    }
}