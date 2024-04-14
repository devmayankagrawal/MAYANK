({
	searchApplicantHelper : function(component, event, helper) {
	
        var action = component.get('c.searchApplicant');
        action.setParams({"objApp" : component.get('v.applicantObject')});
        $A.enqueueAction(action);
        
        action.setCallback(this, function(response){
            if(response.getState()==='SUCCESS'){
                console.log('success'+JSON.stringify(response.getReturnValue()));
                component.set('v.applicantObject',response.getReturnValue());
                component.set('v.showSpinnerFlag',false);
                this.showSuccess(component, event, helper, 'Your Applicant Record is searched successfully...!!');
                
                if(response.getReturnValue()!= null){
                    component.set('v.showTableFlag',true);
                }
                else{
                    component.set('v.showTableFlag',false);
                }
            }
            else{
                console.log('something went wrong');
                component.set('v.showTableFlag',false);
                component.set('v.showSpinnerFlag',false);
            }
        });
          
        
	},
     showSuccess : function(component, event, helper, myMessage) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: myMessage,
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    }

})