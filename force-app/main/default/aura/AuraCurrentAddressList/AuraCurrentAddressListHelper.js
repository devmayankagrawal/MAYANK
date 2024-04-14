({
	searchAddressesHelper : function(component, event, helper) {
		console.log('I am from helper');
        
        var action = component.get('c.searchCurrentAddresses');
        action.setParams({"appId" : component.get('v.recordId')});
        $A.enqueueAction(action);
        
        action.setCallback(this, function(response){
            if(response.getState()==='SUCCESS'){
                console.log('success'+JSON.stringify(response.getReturnValue()));
                component.set('v.addressList', response.getReturnValue());
                component.set('v.showSpinnerFlag',false);
                
                if(response.getReturnValue()!=null){
                    component.set('v.showTableFlag',true);
                }
                else{
                    component.set('v.showTableFlag',false);
                }
            }
            else{
                console.log('Something went wrong');
                component.set('v.showSpinnerFlag',false);
                component.set('v.showTableFlag',false);
            }
        });
	}
})