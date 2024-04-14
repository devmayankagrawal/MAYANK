({
    accTypeHelper : function(component, event, helper) {
        
        var action = component.get('c.getAccountsType');
        action.setParams({"objAcc" : component.get('v.accountObject')});
        $A.enqueueAction(action);
        
        action.setCallback(this, function(response){
            if(response.getState()==='SUCCESS'){
                console.log('success='+JSON.stringify(response.getReturnValue()));
                component.set('v.accList',response.getReturnValue());
                
                if(response.getReturnValue()!= null){
                    component.set('v.showTableFlag',true);
                }
                else{
                    component.set('v.showTableFlag',false);
                }
                component.set('v.showSpinnerFlag',false);
            }
            else{
                console.log('Lochaaaaaaaaa');
                component.set('v.showTableFlag',true);
            }
        });
    }
})