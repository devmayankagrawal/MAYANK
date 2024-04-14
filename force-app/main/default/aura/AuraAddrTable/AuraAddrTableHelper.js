({
	    deleteSelectedAddressesHelper :  function(component, event, helper, myMessage) {
            
            console.log('i am from JS Helper');
            
        var action = component.get('c.deleteSelectAddress');
            action.setParams({"adrList" :  component.get('v.selectedAddressRecordList'), "appObject" : component.get('v.receivedAppObject')});
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                console.log("Record Deleted..!!!");
                component.set('v.receivedAddressList', response.getReturnValue());
                 component.set('v.totalRecords' , response.getReturnValue().length);
                console.log(response.getReturnValue().length);
            }
            else{
                console.log("Locha, something went wrong...!!!!");
            }
        });
        
        $A.enqueueAction(action);
    }

})