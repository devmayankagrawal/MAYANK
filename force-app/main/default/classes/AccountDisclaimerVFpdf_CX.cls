public class AccountDisclaimerVFpdf_CX {
        Public Account objAcc {get; set;}
        Public Boolean showNoteFlag {get; set;}

    public AccountDisclaimerVFpdf_CX(ApexPages.StandardController controller) {
            string accID = apexPages.currentpage().getParameters().get('AccountID');
             objAcc = [select ID, Name, Type, Rating from Account where ID=:accID];
        
                    if(objAcc.Type=='Prospect' && (objAcc.Rating=='Hot' || objAcc.Rating=='Cold') && objAcc.Name.StartsWith('A')){
                            showNoteFlag = true;
                    }
                        else{
                                    showNoteFlag = false;
                        }
    }

}