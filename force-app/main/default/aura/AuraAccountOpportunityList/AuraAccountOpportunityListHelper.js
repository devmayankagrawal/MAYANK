({
	searchOpportunityHelper : function(component, event, helper) {
		console.log('JS Helper');
        
        var action = component.get('c.searchOpportunity');
        action.setParams({"objOpp" : component.get('v.oppObj')});
        action.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                console.log('Success ' + JSON.stringify(response.getReturnValue()));
                component.set('v.opportunityList', response.getReturnValue());
            }
            else {
                console.log('Fail');
            }
        });
        $A.enqueueAction(action);
	}
})