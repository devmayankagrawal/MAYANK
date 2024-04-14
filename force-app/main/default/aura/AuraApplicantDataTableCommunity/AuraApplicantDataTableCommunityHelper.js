({
	fetchAllAplicantHelper : function(component, event, helper) {
		
        var action = component.get('c.getAllApplicants');
        $A.enqueueAction(action);
        
        action.setCallback(this, function(response){
            if(response.getState()==='SUCCESS'){
                console.log('success='+JSON.stringify(response.getReturnValue()));
                component.set('v.applicantList',response.getReturnValue());
            }
            else{
                console.log('lochaaaaaaaa');
            }
        });
	}
})