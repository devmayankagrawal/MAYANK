({
    createNewAccountHelper : function(component, event, helper) {
        
        console.log('I am from JS Helper Method');
        
        var accName = component.get('v.accountObject.Name');
        var accType = component.get('v.accountObject.Type');
        var accSLA = component.get('v.accountObject.SLA__c');
        
        console.log('Account Name ='+accName+' Type ='+accType+' SLA ='+accSLA);
        
        // calling apex Controller method
        
        var objAccount = component.get('v.accountObject');
        
        var action = component.get('c.createAccountRecord');
        action.setParams({'objAcc' : objAccount});
        $A.enqueueAction(action);
        
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if(state==='SUCCESS'){
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