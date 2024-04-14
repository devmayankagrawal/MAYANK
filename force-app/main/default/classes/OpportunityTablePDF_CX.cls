public class OpportunityTablePDF_CX {
     Public List<Opportunity> oppList {get; set;}

    public OpportunityTablePDF_CX(ApexPages.StandardController controller) {
    string accName = ApexPages.CurrentPage().getParameters().get('AccountName');
    if(string.isNotBlank(accName)){
    oppList = [select ID, Account.Name, Name, Type, LeadSource, Amount, StageName from Opportunity where Amount>=10000 and Account.Name=: accName];
    system.debug('#Opportunity List='+oppList);
          }

    }

}