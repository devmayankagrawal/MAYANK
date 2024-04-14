({
	showAddressesHelper : function(component, event, helper) {
		
        var action = component.get('c.newSearchAddresses');
        action.setParams({"objApp" : component.get('v.applicantObject')});
        
        action.setCallback(this, function(response){
            if(response.getState()==='SUCCESS'){
                console.log('received='+JSON.stringify(response.getReturnValue()));
                component.set('v.addressList', response.getReturnValue());
                
                if(response.getReturnValue()!=null){
                    var AppAddrEventFire = $A.get('e.c:AppAddrEvent');
                    AppAddrEventFire.setParams({"AppAdrEventAddressList" : component.get('v.addressList'), "eventAppObject" : component.get('v.applicantObject')});
                    AppAddrEventFire.fire();
                }
                
            }
            else{
                console.log('something went wrong');
                 var AppAddrEventFire = $A.get('e.c:AppAddrEvent');
                    AppAddrEventFire.setParams({"AppAdrEventAddressList" : null});
                    AppAddrEventFire.fire();
            }
        });
        
        $A.enqueueAction(action);
	}
})