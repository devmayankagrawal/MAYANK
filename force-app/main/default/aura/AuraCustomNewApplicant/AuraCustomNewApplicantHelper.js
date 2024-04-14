({
	createNewApplicantHelper : function(component, event, helper) {
		console.log('I am from JS Helper Method');
        
       // Calling Apex Controller Method 
       
        var objApp = component.get('v.applicantObject');
        
        var action = component.get('c.createApplicantRecord');
        action.setParams({'objApplicant' : objApp});
        $A.enqueueAction(action);
        
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if(state==="SUCCESS"){
                console.log('success');
                this.showSuccess();
            }
            else{
                console.log('failed');
            }
            
        });
	},
    
     showSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'Record Created...!!!',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    }

    
})