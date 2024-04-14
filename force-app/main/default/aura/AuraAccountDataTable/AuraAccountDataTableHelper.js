({
    showOpportunitiesHelper : function(component, event, helper) {
        
        console.log('In JS Helper');
        
        var action = component.get('c.searchCurrentOpportunities');
        action.setParams({"accId" : component.get('v.recordId')});
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                console.log('success '+JSON.stringify(response.getReturnValue()));
                component.set('v.opportunityList', response.getReturnValue());    
                
                component.set('v.totalRecords' , response.getReturnValue().length);
                
                var oppAccRecord = JSON.parse( JSON.stringify( response.getReturnValue() ) );
                oppAccRecord = oppAccRecord.map( row => {
                    return { row,Name: row.Name, AccountName: row.Account.Name, StageName: row.StageName, Amount: row.Amount};
                                                })
                console.log('Account = ' + JSON.stringify(oppAccRecord));
                component.set('v.opportunityList', oppAccRecord);
                
                
                
                if(response.getReturnValue()!=null){
                    component.set('v.showTableFlag', true);                    
                }
                else{
                    component.set('v.showTableFlag', false);
                }                
                component.set('v.showSpinnerFlag', false); 
                
                this.showSuccess(component, event, helper, 'Account opportunity Searched Succesfully..!!!');
            }
            
            else{
                console.log('something went wrong...!!!!');
                component.set('v.showTableFlag', false);
                component.set('v.showSpinnerFlag', false);
                
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
    },
    
    deleteSelectedOpportunityHelper :  function(component, event, helper, myMessage) {
        var action = component.get('c.deleteSelectedOpportunity');
        action.setParams({"oppList" :  component.get('v.selectedOpportunityRecordList') , "accId" : component.get('v.recordId') });
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                console.log("Record Deleted..!!!");
                component.set('v.opportunityList', response.getReturnValue());
                 component.set('v.totalRecords' , response.getReturnValue().length);
            }
            else{
                console.log("Locha, something went wrong...!!!!");
            }
        });
        
        $A.enqueueAction(action);
    }

    
})