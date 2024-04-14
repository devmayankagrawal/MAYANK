public class AccountToContactTablePDF_CX {
                  Public List<Account> accList {get; set;}

    public AccountToContactTablePDF_CX(ApexPages.StandardController controller) {
                  
               
                   accList = [select Name,(select ID, FirstName, LastName from Contacts) from Account ];

    }

}