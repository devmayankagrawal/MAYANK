({
	searchApplicantHelper : function(component, event, helper) {
		
        
        var action = component.get('c.searchApplicant');
        action.setParams({'objApp' : component.get('v.applicantObject')});
        $A.enqueueAction(action);
        
        action.setCallback(this, function(response){
            if(response.getState()==='SUCCESS'){
                console.log('success'+JSON.stringify(response.getReturnValue()));
                component.set('v.applicantObject', response.getReturnValue());
                this.showSuccess();
                component.set('v.showSpinnerFlag',false);
            }
            else{
                console.log('Something went wrong..!!');
                component.set('v.showSpinnerFlag',false);
            }
        });
	},
    
            showSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'Record Found...!!!',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    }

})