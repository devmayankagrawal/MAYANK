({
    showAccountDataHelper : function(component, event, helper) {
        console.log('I am from JS Helper');
        
        var action = component.get('c.searchAccount');
        action.setParams({"objAcc" : component.get('v.accountObject')});
        $A.enqueueAction(action);
        
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS'){
                console.log('success'+JSON.stringify(response.getReturnValue()));
                component.set('v.accountObject',response.getReturnValue());
                this.showOpportunityDataHelper(component, event, helper);
            }
            else{
                console.log('lochaa');
            }
        });
    },
    
    showOpportunityDataHelper : function(component, event, helper){
        console.log("I am from Opportunity");
        
        var action = component.get('c.searchAccountOpportunity');
        action.setParams({"objAcc" : component.get('v.accountObject')});
        $A.enqueueAction(action);
        
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS'){
                console.log('Opp success '+JSON.stringify(response.getReturnValue()));
                component.set('v.oppList' , response.getReturnValue());
                component.set('v.totalRecords' , response.getReturnValue().length);
                
            }
            else{
                console.log('lochaa');
            }
        });
    },
    deleteSelectedOpportunityHelper :  function(component, event, helper, myMessage) {
        
        console.log('i am from JS Helper');
        
        var action = component.get('c.deleteOpportunities');
        action.setParams({"accList" :  component.get('v.selectedOpportunityRecordList'), "accObject" : component.get('v.accountObject')});
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                console.log("Record Deleted..!!!"+JSON.stringify(response.getReturnValue()));
                component.set('v.oppList',response.getReturnValue());
                console.log(response.getReturnValue().length);
                component.set('v.totalRecords' , response.getReturnValue().length);
                
            }
            else{
                console.log("Locha, something went wrong...!!!!");
            }
        });
        
        $A.enqueueAction(action);
    }
    
})