({
    searchAccountHelper : function(component, event, helper) {
        
        console.log('Type = '+component.get('v.accountObject.Type'));
        
        
        var action = component.get('c.searchAccount'); 	//1
        action.setParams({"objAcc" : component.get('v.accountObject')}); //2
        $A.enqueueAction(action); //3
        
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                console.log('Success '+ JSON.stringify(response.getReturnValue()) );                
                component.set('v.accountObject' , response.getReturnValue());                
                this.showSuccess();
                component.set('v.showSpinnerFlag', false);
                
            }
            else{
                console.log('Something went wrong...!!!!'); 
                component.set('v.showSpinnerFlag', false);
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