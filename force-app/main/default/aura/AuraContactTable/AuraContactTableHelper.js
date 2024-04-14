({
	showContactsHelper : function(component, event, helper) {
		
        var action = component.get('c.searchContact');
        action.setParams({"objAcc" : component.get('v.accountObject')});
        
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS'){
                console.log('success'+JSON.stringify(response.getReturnValue()));
                component.set('v.contactList',response.getReturnValue());
                component.set('v.totalRecords' , response.getReturnValue().length);
            }
            else{
                console.log('Something went wrong');
            }
        });
        
        $A.enqueueAction(action);
	},
    
     deleteSelectedContactsHelper :  function(component, event, helper, myMessage) {
            
            console.log('i am from JS Helper');
            
        var action = component.get('c.deleteContact');
        action.setParams({"ConList" :  component.get('v.selectedContactRecordList')});
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                console.log("Record Deleted..!!!");
                component.set('v.contactList', response.getReturnValue());
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