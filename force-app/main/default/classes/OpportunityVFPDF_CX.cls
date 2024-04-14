public class OpportunityVFPDF_CX {
public Opportunity objOpp {get; set;}

    public OpportunityVFPDF_CX(ApexPages.StandardController controller) {
    
    string oppName = apexPages.currentpage().getParameters().get('OpportunityName');
    
    system.debug('#OpportunityName='+oppName);
    if(string.isNotBlank(oppName)){
     objOpp = [select Name, Type, LeadSource, CloseDate, Amount, StageName from Opportunity where Name=:oppName Limit 1];
    }
    else{
    system.debug('Opportunity Name should not be blank');
    }

    }

}