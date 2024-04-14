({
    createAccountHelper : function(component, event, helper) {
        
    },
    searchAccountHelper : function(component, event, helper) {
        
        var action = component.get('c.searchAccount');
        action.setParams({"objAcc" : component.get('v.accountObject')});
        $A.enqueueAction(action);
        
        action.setCallback(this, function(res){
            if(res.getState()==='SUCCESS'){
                console.log('success'+JSON.stringify(res.getReturnValue()));
                component.set('v.accountObject', res.getReturnValue());
                this.showSuccess(component, event, helper, 'Record Searched Successfully..');
                component.set('v.showSpinnerFlag',false);
                
            }
            else{
                console.log('something went wrong');
                component.set('v.showSpinnerFlag',false);
               
            }
        });
    },
    updateAccountHelper : function(component, event, helper) {
        
        var action = component.get('c.updateAccount');
        action.setParams({"objAcc" : component.get('v.accountObject')});
        $A.enqueueAction(action);
        
        action.setCallback(this, function(res){
            if(res.getState()==='SUCCESS'){
                console.log('success'+JSON.stringify(res.getReturnValue()));
                this.showSuccess(component, event, helper, 'Record Updated Successfully..');
                component.set('v.showSpinnerFlag',false);
                
            }
            else{
                console.log('something went wrong');
                component.set('v.showSpinnerFlag',false);
                
            }
        });
    },
    deleteAccountHelper : function(component, event, helper) {
        
        var action = component.get('c.deleteAccount');
        action.setParams({"objAcc" : component.get('v.accountObject')});
        $A.enqueueAction(action);
        
        action.setCallback(this, function(res){
            if(res.getState()==='SUCCESS'){
                console.log('success'+JSON.stringify(res.getReturnValue()));
                this.showSuccess(component, event, helper, 'Record Deleted Successfully..');
                component.set('v.showSpinnerFlag',false);
            }
            else{
                console.log('something went wrong');
                component.set('v.showSpinnerFlag',false);
            }
        });
    },
     saveAccountHelper : function(component, event, helper) {
        
         var action = component.get('c.createAccountRecord');
         action.setParams({"objAcc" : component.get('v.accountObject')});
         $A.enqueueAction(action);
         
         action.setCallback(this, function(res){
             if(res.getState()==='SUCCESS'){
                 console.log('sucess'+JSON.stringify(res.getReturnValue()));
                 this.showSuccess(component, event, helper, 'Record Created Successfully..');
                 component.set('v.showSpinnerFlag',false);
                 
             }
             else{
                 console.log('something went wrong');
                 component.set('v.showSpinnerFlag',false);
             }
         })
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