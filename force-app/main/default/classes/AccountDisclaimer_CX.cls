public class AccountDisclaimer_CX {
     Public Account objAcc {get; set;}
     Public Boolean showNoteFlag {get; set;}

    public AccountDisclaimer_CX(ApexPages.StandardController controller) {
       string accId = apexPages.CurrentPage().getParameters().get('AccountID');
       
       
           objAcc = [select ID, Name, Type, Rating from Account where ID=:accId];
           
           if(objAcc.Type=='Prospect' && (objAcc.Rating=='Hot' || objAcc.Rating=='Cold') && objAcc.Name.StartsWith('A')){
                       showNoteFlag=true;
           }
                   else{
                           showNoteFlag=false;
                   }
       

    }

}