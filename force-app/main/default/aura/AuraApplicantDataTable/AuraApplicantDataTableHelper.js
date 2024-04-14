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
                component.set('v.TotalRecords', response.getReturnValue().length);
                component.set('v.showSpinnerFlag',false);
                this.showSuccess(component, event, helper, 'Record searched Successfully...');
                
                if(response.getReturnValue()!=null){
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
    deleteSelectedAddressesHelper : function(component, event, helper){
        
        var action = component.get('c.deleteSelectedAddresses');
        action.setParams({"adrList" : component.get('v.selectedAddressRecordList'), "appId" : component.get('v.recordId')});
        action.setCallback(this, function(response){
            if(response.getState()==='SUCCESS'){
                console.log("Records Deleted...")
                component.set('v.addressList', response.getReturnValue());
                component.set('v.TotalRecords', response.getReturnValue().length);
                this.showSuccess(component, event, helper, 'Record Deleted Successfully...');
                component.set('v.showSpinnerFlag',false);
               
            }
            else{
                console.log('Something went wrong');
                component.set('v.showSpinnerFlag',false);
            }
        });
        
        $A.enqueueAction(action);
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