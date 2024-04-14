public class AccVFDisclaimer_CX {

        public Account objAcc {get;set;}
        public Boolean showDisclaimerFlag {get;set;}

    public AccVFDisclaimer_CX(ApexPages.StandardController controller) {
    
        string accId = ApexPages.currentPage().getParameters().get('AccountId');
        
        
           Account objAcc = [select Id,Name,Type,Rating from Account where Id=:accId];
           system.debug('#Applicant Record='+objAcc);
               if(objAcc.Type=='Prospect' && (objAcc.Rating=='Hot' || objAcc.Rating=='Cold') && objAcc.Name.StartsWith('A')){
                   showDisclaimerFlag=true;
               
               }
                   else{
                       showDisclaimerFlag=false;
                   }
        }
    

}