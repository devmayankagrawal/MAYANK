trigger OpportunityTrigger on Opportunity (before insert, before update) {

    for(Opportunity objOpp : trigger.new){

        if(objOpp.LeadSource=='Web' && objOpp.StageName=='Closed Won'){

            objOpp.Description='I am Won';

        }
        else{
            objOpp.Description='';
        }
    }
}