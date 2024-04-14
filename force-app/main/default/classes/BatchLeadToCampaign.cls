global class BatchLeadToCampaign implements Database.Batchable<sObject>{

   global database.QueryLocator start(Database.BatchableContext Bc){
        return database.getQueryLocator('select Id,Name,AnnualRevenue,LeadSource,CampaignId from Lead where Name like \'Mo%\' and (AnnualRevenue >=8000 and AnnualRevenue <=9500) and (LeadSource=\'Web\' Or LeadSource=\'Purchased List\')');
    }
    
   global void execute(Database.BatchableContext Bc,List<Lead> leadList){
        
    }
    
    global void finish(Database.BatchableContext Bc){
        
    }
    
}